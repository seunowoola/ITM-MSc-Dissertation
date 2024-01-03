
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/constants/textField.dart';
import 'package:hostel_management/screens/sign_up.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:page_transition/page_transition.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String emailText = "";
  String passwordText = "";

  final TextEditingController _eController = TextEditingController();
  final TextEditingController _pController = TextEditingController();

  bool hidePassword = true;

  final AppLogic _appLogic = AppLogic();

  bool adminLogin = false;
  bool loading  = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;



  void _requestFocus(){
    setState(() {
      FocusScope.of(context).requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      body: loading ? const LoadingIndicator() : GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 1, color: Colors.white),
                            image: const DecorationImage(
                                image: AssetImage("assets/images/logos.png",), fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(bottom: 20, right: 30),
                      child: Align(
                          alignment: Alignment(1,5),
                          child: Text("Login", style: TextStyle(
                            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600,
                          ),)),
                    )
                  ],
                ),


              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView(
                    shrinkWrap: true,
                    children: [

                      const SizedBox(height: 30,),

                      TextFieldWidget(
                        onTap: (){
                          _requestFocus();
                        },
                        onChangedFunc: (value){
                          setState(() {
                            emailText = value;
                          });
                        },

                        focusNode: emailFocusNode,
                        enabledColor: emailText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        labelColor: emailFocusNode.hasFocus || emailText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        sufIcon: Icon(Icons.email, color: emailFocusNode.hasFocus || emailText.isNotEmpty ? mainColor : mainGreyColor,),
                        inputType: TextInputType.emailAddress,
                        validator: (value){
                          final bool isValid = EmailValidator.validate(value!.trim());
                          return !isValid ? "Enter a valid email" : null;
                        },
                        obscureText: false,
                        controller: _eController,
                        labelText: "Email",
                      ),

                      const SizedBox(height: 20,),

                      TextFieldWidget(
                        onTap: (){
                          _requestFocus();
                        },
                        onChangedFunc: (value){
                          setState(() {
                            passwordText = value;
                          });
                        },
                        maxLine: 1,
                        focusNode: passwordFocusNode,
                        enabledColor: passwordText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        labelColor: passwordFocusNode.hasFocus || passwordText.isNotEmpty ? mainColor.withOpacity(0.4) : mainGreyColor,
                        sufIcon: IconButton(
                          icon:  Icon(
                            Icons.remove_red_eye,
                            color: hidePassword ? mainGreyColor: mainColor,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                        inputType: TextInputType.text,
                        validator: (value){
                          return value == null || value.isEmpty ?
                          "Enter your password" : value.length < 6 ? "Invalid password length" : null;
                        },
                        obscureText: hidePassword,
                        controller: _pController,
                        labelText: "Password",
                      ),

                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                adminLogin = !adminLogin;
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: adminLogin ? mainColor : Colors.white,
                                border: Border.all(width: 0.5, color: mainColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(child: Icon(Icons.check, color: Colors.white, size: 20,),),
                            ),
                          ),
                          const SizedBox(width: 8,),
                          const Text('Login as an Admin', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                        ],
                      ),

                      const SizedBox(height: 45,),

                       Center(
                        child:  Center(child: ButtonWidget(title: "Login", width: 200, titleColor: Colors.white,
                          onTap: (){

                            if(_formKey.currentState!.validate()){

                              setState(() {
                                loading = true;
                              });

                              _appLogic.signIn(
                                  userType: adminLogin ? "admin" : "user",
                                  email: _eController.text.trim(),
                                  password: _pController.text.trim(),
                                  stopLoad: (){
                                    setState(() {
                                      loading = false;
                                    });
                                  },
                                  context: context);

                            }else{
                              Fluttertoast.showToast(msg: "Fill all information");
                            }

                          },
                      ))),

                      const SizedBox(height: 25,),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text("Don't have an Account? ", style: TextStyle(fontSize: 18),),
                          InkWell(child: const Text("Register Here", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      duration: const Duration(milliseconds: 100),
                                      type: PageTransitionType.leftToRight,
                                      child: const SignUp())
                              );
                            },
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
