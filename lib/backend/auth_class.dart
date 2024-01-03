import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_management/backend/user_class.dart';



class AuthClass{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  UserClass _userGetFromFirebase(User user){
    return UserClass(userId: user.uid);
  }

  Future registerWithEmailAndPassword({required String email, required String password})async{
    try{
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? registerUser = result.user;
      return _userGetFromFirebase(registerUser!);
    }catch(e){
      print(e.toString());
    }
  }

  Future signInWithEmail({required String email, required String password})async{
    try{
      var signIn = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? signedUer = signIn.
      user;
      return _userGetFromFirebase(signedUer!);
    }catch(e){
      print("The error happening is ================== ${e.toString()}");
    }
  }


  Future signInOut()async{
    try{
      _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}