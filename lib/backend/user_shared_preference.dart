
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static String emailPref = "mailPref";
  static String namePref = "namePref";
  static String genderPref = "genderPref";
  static String phoneNoPref = "phoneNoPref";
  static String regNo = "regNo";
  static String profilePhotoPref = "profilePhoto";
  static String userTypePref = "userType";
  static String loggedInPref = "isLoggedIn";
  static String roomNo = "userRoomNo";


  static String nokName = "nokName";
  static String nokEmail = "nokEmail";
  static String nokMobileNo = "nokMobileNo";
  static String nokRelationship = "relationship";

  // ========================= SETTING PREFERENCES ========================


  static Future setUserEmail({required String userEmail})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(emailPref, userEmail);
  }

  static Future setUserName({required String userName})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(namePref, userName);
  }

  static Future <bool> setLoggedIn({required bool logPrefs})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setBool(loggedInPref, logPrefs);
  }

  static Future setUserGender({required String userGender})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(genderPref, userGender);
  }

  static Future setUserPhoneNo({required String userPhoneNo})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(phoneNoPref, userPhoneNo);
  }

  static Future setRegNo({required String userRegNo})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(regNo, userRegNo);
  }

  static Future setProfilePhoto({required String profilePhoto})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(profilePhotoPref, profilePhoto);
  }

  static Future setLoginType({required String userType})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(userTypePref, userType);
  }


  static Future setNokName({required String name})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(nokName, name);
  }


  static Future setNokEmail({required String email})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(nokEmail, email);
  }

  static Future setNokRelationship({required String relationship})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(nokRelationship, relationship);
  }

  static Future setNokMobileNo({required String mobileNo})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(nokMobileNo, mobileNo);
  }

  static Future setRoomNo({required String room})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(roomNo, room);
  }



// ========================= GETTING PREFERENCES ========================

  static Future getUserEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(emailPref);
  }

  static Future getUserName()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(namePref);
  }


  static Future getUserGender()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(genderPref);
  }

  static Future getUserPhoneNo()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(phoneNoPref);
  }

  static Future getMatricNo()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(regNo);
  }

  static Future getProfilePhoto()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(profilePhotoPref);
  }

  static Future <bool?> getLoggedPref()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(loggedInPref);
  }

  static Future getUserType()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userTypePref);
  }

  static Future getRoomNo()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(roomNo);
  }



  static Future getNokName()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nokName);
  }

  static Future getNokEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nokEmail);
  }

  static Future getNokMobileNo()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nokMobileNo);
  }

  static Future getNokRelationship()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nokRelationship);
  }





}