import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/screens/login.dart';
import 'package:hostel_management/screens/next_of_kin.dart';
import 'package:hostel_management/screens/sign_up.dart';
import 'package:hostel_management/screens/splash_screen.dart';
import 'package:hostel_management/screens/user_photo_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
        useMaterial3: true,
      ),
      // home: const Login(),
      home: const SplashScreen(),
    );
  }
}


