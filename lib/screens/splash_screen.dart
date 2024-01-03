import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/Admin/admin_home_page.dart';
import 'package:hostel_management/User/user_home_screen.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/screens/login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool userLoginStatus = false;
  String userType = "";
  getUserLoginStatus(){
    UserPreferences.getLoggedPref().then((value) {
      if(value == null){
        setState(() {
          userLoginStatus = false;
        });
      }else{
        setState(() {
          userLoginStatus = value;
        });
      }
    });

    UserPreferences.getUserType().then((value) {
      if (value != null){
        setState(() {
          userType = value;
        });
      }

    });
  }


  //
  void nextPage(){

    Future.delayed(const Duration(seconds: 4)).then((value) =>   Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) {

          // return  const Login(); // to be removed

      if (userLoginStatus == false){
        return const Login();
      }else if (userLoginStatus == true && userType == "user"){
        return const UserHomePage();
      }else if (userLoginStatus == true && userType == "admin"){
        return const AdminHomePage();
      }else{
        return const Login();
      }
    }),

    ));
  }


  runRequest()async{
    await getUserLoginStatus();
    nextPage();
  }

  @override
  void initState() {
    runRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor:Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            const SizedBox(),

          Column(
            children: [
              Center(
                child: Image.asset("assets/images/splash-logo.png", height: 200,),
              ),
              const SizedBox(height: 10,),
              const Text("HOSTEL MANAGEMENT SYSTEM", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: mainColor),),
            ],
          ),



            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: LoadingIndicator(),
            )
          ],
        ),

      )
    );
  }
}

