import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/Admin/admin_home_page.dart';
import 'package:hostel_management/User/user_home_screen.dart';
import 'package:hostel_management/backend/auth_class.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/navigation.dart';
import 'package:hostel_management/screens/login.dart';
import 'package:hostel_management/screens/next_of_kin.dart';
import 'package:hostel_management/screens/user_photo_page.dart';
import 'package:intl/intl.dart';


final DatabaseServices _databaseServices = DatabaseServices();
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
final AuthClass _authClass = AuthClass();

class AppLogic {

  void signup({required String email,
    required String password,
    required String name,
    required String regNo,
    required String phoneNo,
    required String roomNo,
    required String gender, required BuildContext context, required Function () stopLoading}) async {
    DateTime datetime = DateTime.now();
    var date = DateFormat("dd/MM/yyyy").format(datetime).toString();
    var time = DateFormat.jm().format(datetime);
    var dateOrder = DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(datetime)
        .toString();


    var registered = await _authClass.registerWithEmailAndPassword(
        email: email, password: password);
    if (registered != null) {
      // if (userType == "user") {
        await _databaseServices
            .storeUserInfo(
            userId: _auth.currentUser!.uid,
            userInfo: <String, dynamic>{

              "name": name,
              "email": _auth.currentUser!.email,
              "regNo": regNo,
              "gender": gender,
              "phoneNo": phoneNo,
              "uid": _auth.currentUser!.uid,
              "register_date": date,
              "register_time": time.toString(),
              "orderingDate": dateOrder,
              "photo": "",
              "nextOfKinName": "",
              "nextOfKinEmail": "",
              "relationship": "",
              "nextOfKinPhoneNo": "",
              "roomNo": roomNo,
            });

        // ===============Saving data into preference ===============

        UserPreferences.setUserName(userName: name);
        UserPreferences.setUserEmail(userEmail: email);
        UserPreferences.setUserGender(userGender: gender);
        UserPreferences.setUserPhoneNo(userPhoneNo: phoneNo);
        UserPreferences.setProfilePhoto(profilePhoto: "");
        UserPreferences.setRegNo(userRegNo: regNo);
        UserPreferences.setRoomNo(room: roomNo);
        UserPreferences.setLoginType(userType: "user");


        await Fluttertoast.showToast(
          msg: "Registration successful",
        );

        Future.delayed(const Duration(seconds: 6)).then((value) =>
            navigateAndRemoveUntilRoute(context, const UserPhotoUpload()));

    } else {
      stopLoading();
      Fluttertoast.showToast(
        msg: "Registration Failed",
      );
    }
  }


  // ==================================== Upload Registered User Photo
  void uploadRegisterUserPhoto({required passportUrl, required Function () stopLoading,
    required Function () navigateFunc,
  }) async {
    // BuildContext context = BuildContext as BuildContext;
    await _databaseServices.updateInfo(
      collectionName: "user",
      userId: _auth.currentUser!.uid,
      userInfo: {
        "photo": passportUrl,
      },

    ).then((value) {

      UserPreferences.setProfilePhoto(profilePhoto: passportUrl);

      navigateFunc();
    });
  }



  // ==================================== Upload Registered Next of  Kin
  void uploadNextOfKin({required name, required email, required relationship, required mobileNo, required Function () stopLoading,
    required Function () navigateFunc,
  }) async {
    await _databaseServices.updateInfo(
      collectionName: "user",
      userId: _auth.currentUser!.uid,
      userInfo: {

        "nextOfKinName": name,
        "nextOfKinEmail": email,
        "relationship":relationship,
        "nextOfKinPhoneNo": mobileNo,
      },

    ).then((value) {

      UserPreferences.setNokName(name: name);
      UserPreferences.setNokEmail(email: email);
      UserPreferences.setNokRelationship(relationship: relationship);
      UserPreferences.setNokMobileNo(mobileNo: mobileNo);
      UserPreferences.setLoggedIn(logPrefs: true);
      UserPreferences.setLoginType(userType: "user");

      navigateFunc();
    });
  }


  // ==================================== Update Next of  Kin
  void updateNOK({required name, required email, required relationship, required mobileNo, required Function () stopLoading,
    required Function () navigateFunc,
  }) async {
    await _databaseServices.updateInfo(
      collectionName: "user",
      userId: _auth.currentUser!.uid,
      userInfo: {

        "nextOfKinName": name,
        "nextOfKinEmail": email,
        "relationship":relationship,
        "nextOfKinPhoneNo": mobileNo,
      },

    ).then((value) {

      UserPreferences.setNokName(name: name);
      UserPreferences.setNokEmail(email: email);
      UserPreferences.setNokRelationship(relationship: relationship);
      UserPreferences.setNokMobileNo(mobileNo: mobileNo);

      navigateFunc();
    });
  }

  // ==================================== Update User Info

  void updateUserDetails({required String field, required String fieldValue, required BuildContext context, required Function () stopLoading}) async {
    await _databaseServices.updateInfo(
        userId: _auth.currentUser!.uid, collectionName: "user",
        userInfo: <String, dynamic>{
          field: fieldValue,
        });

    await Fluttertoast.showToast(
      msg: "Update successful",
    );

    Future.delayed(const Duration(seconds: 4)).then((value) =>
    field != "email" ? goBack(context, fieldValue): null);
  }







  void signIn({required String userType, required String email, required String password, required Function () stopLoad, required BuildContext context, })async{
    _authClass.signInWithEmail(email: email, password: password).then((value) async{
      if (value != null){
        QuerySnapshot query = await _firebaseFireStore.collection(userType).where("uid", isEqualTo: _auth.currentUser?.uid).get();
        final List <DocumentSnapshot> docSnap = query.docs;
        if (docSnap.isEmpty){
          stopLoad();
          Fluttertoast.showToast(msg: "User not found");
          _authClass.signInOut();
        }else{

          stopLoad();

          if (userType == "user"){
            String photo = docSnap[0].get("photo");
            String nok = docSnap[0].get("nextOfKinName");
            if ((docSnap[0].get("photo") != null) && photo.isNotEmpty && (docSnap[0].get("nextOfKinName") != null && nok.isNotEmpty)){

              UserPreferences.setLoginType(userType: userType);
              UserPreferences.setLoggedIn(logPrefs: true);
              UserPreferences.setUserName(userName: docSnap[0].get("name"));
              UserPreferences.setUserEmail(userEmail: docSnap[0].get("email"));
              UserPreferences.setUserGender(userGender: docSnap[0].get("gender"));
              UserPreferences.setUserPhoneNo(userPhoneNo: docSnap[0].get("phoneNo"));
              UserPreferences.setRegNo(userRegNo: docSnap[0].get("regNo"));
              UserPreferences.setProfilePhoto(profilePhoto: docSnap[0].get("photo"));
              UserPreferences.setRoomNo(room: docSnap[0].get("roomNo"));


              UserPreferences.setNokName(name: docSnap[0].get("nextOfKinName"));
              UserPreferences.setNokEmail(email: docSnap[0].get("nextOfKinEmail"));
              UserPreferences.setNokRelationship(relationship: docSnap[0].get("relationship"));
              UserPreferences.setNokMobileNo(mobileNo: docSnap[0].get("nextOfKinPhoneNo"));


              Future.delayed(const Duration(milliseconds: 50)).then((value) =>
                  navigateAndRemoveUntilRoute(context, const UserHomePage()));

            }else if (photo.isEmpty){
              UserPreferences.setUserName(userName: docSnap[0].get("name"));
              UserPreferences.setUserEmail(userEmail: docSnap[0].get("email"));
              UserPreferences.setUserGender(userGender: docSnap[0].get("gender"));
              UserPreferences.setUserPhoneNo(userPhoneNo: docSnap[0].get("phoneNo"));
              UserPreferences.setRegNo(userRegNo: docSnap[0].get("regNo"));
              UserPreferences.setRoomNo(room: docSnap[0].get("roomNo"));

              Future.delayed(const Duration(milliseconds: 50)).then((value) =>
                  navigateAndRemoveUntilRoute(context, const UserPhotoUpload()));
            }else{
              UserPreferences.setUserName(userName: docSnap[0].get("name"));
              UserPreferences.setUserEmail(userEmail: docSnap[0].get("email"));
              UserPreferences.setUserGender(userGender: docSnap[0].get("gender"));
              UserPreferences.setUserPhoneNo(userPhoneNo: docSnap[0].get("phoneNo"));
              UserPreferences.setRegNo(userRegNo: docSnap[0].get("regNo"));
              UserPreferences.setProfilePhoto(profilePhoto: docSnap[0].get("photo"));
              UserPreferences.setRoomNo(room: docSnap[0].get("roomNo"));

              Future.delayed(const Duration(milliseconds: 50)).then((value) =>
                  navigateAndRemoveUntilRoute(context, const NextOfKin()));
            }


          }else if (userType == "admin"){
            UserPreferences.setLoggedIn(logPrefs: true);
            UserPreferences.setLoginType(userType: "admin");
            Future.delayed(const Duration(milliseconds: 50)).then((value) =>
                navigateAndRemoveUntilRoute(context, const AdminHomePage()));

          }

          await Fluttertoast.showToast(
              msg: "Login successful");
        }

      }else{
        stopLoad();
        await Fluttertoast.showToast(msg: "Invalid details");
      }
    });
  }

  logOut({required BuildContext context, required Function () loading, required Function () stopLoading})async{
    loading();
    await _authClass.signInOut();
    await UserPreferences.setLoggedIn(logPrefs: false);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      stopLoading();
      navigateAndRemoveUntilRoute(context, const Login());
    });

  }

  Future resetEmail({required String newEmail}) async {

    try{
      _auth.currentUser!.updateEmail(newEmail).then((value){
        Fluttertoast.showToast(msg: "Update Successful", );
      }
      );
    }catch(e){
      return e.toString();
    }
  }



  Future resetPassword({required String newPassword}) async {

    try{
      _auth.currentUser!.updatePassword(newPassword).then((value){
        Fluttertoast.showToast(msg: "Update Successful", );
      }
      );
    }catch(e){
      return e.toString();
    }
  }


}
