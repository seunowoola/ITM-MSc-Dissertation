import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/constants/textField.dart';
import 'package:hostel_management/screens/login.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:page_transition/page_transition.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode regNoFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();
  FocusNode roomNoFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String emailText = "";
  String passwordText = "";
  String nameText  = "";
  String regNoText  = "";
  String mobileNoText = "";
  String roomNoText = "";

  String gender = "";
  String groupValue = "";

  final AppLogic _appLogic = AppLogic();

  @override
  void initState() {
    super.initState();
    // initProcess();


  }

  final TextEditingController _eController = TextEditingController();
  final TextEditingController _pController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roomNoController = TextEditingController();

  bool hidePassword = true;
  bool loading = false;

  // final AuthClass _authClass = AuthClass();
  // final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final DatabaseServices _databaseServices = DatabaseServices();

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
                      bottomLeft: Radius.circular(100),
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
                          child: Text("Sign Up", style: TextStyle(
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

                      const SizedBox(height: 20,),

                      TextFieldWidget(
                        onTap: (){
                          _requestFocus();
                        },
                        onChangedFunc: (value){
                          setState(() {
                            nameText = value;
                          });
                        },

                        focusNode: nameFocusNode,
                        enabledColor: nameText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        labelColor: nameFocusNode.hasFocus || nameText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        sufIcon: Icon(Icons.person, color: nameFocusNode.hasFocus || nameText.isNotEmpty ? mainColor : mainGreyColor,),
                        inputType: TextInputType.text,
                        validator: (value){
                          return value == null || value.isEmpty ?
                          "Enter your name" : null;
                        },
                        obscureText: false,
                        controller: _nameController,
                        labelText: "Name",
                      ),

                      const SizedBox(height: 20,),

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
                          return !isValid ? "Enter a valid email address" : null;
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
                        labelColor: passwordFocusNode.hasFocus || passwordText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        sufIcon: IconButton(
                          icon:  Icon(
                            Icons.remove_red_eye,
                            color: hidePassword ? mainGreyColor : mainColor,
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


                      TextFieldWidget(
                        onTap: (){
                          _requestFocus();
                        },
                        onChangedFunc: (value){
                          setState(() {
                            regNoText = value;
                          });
                        },

                        focusNode: regNoFocusNode,
                        enabledColor: regNoText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        labelColor: regNoFocusNode.hasFocus || regNoText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        sufIcon: Icon(Icons.school_rounded, color: regNoFocusNode.hasFocus || regNoText.isNotEmpty ? mainColor : mainGreyColor,),
                        // inputType: TextInputType.,
                        validator: (value){
                          return value == null || value.isEmpty ?
                          "Enter your Registration no" : null;
                        },
                        obscureText: false,
                        controller: _regNoController,
                        labelText: "Registration No",
                      ),

                      const SizedBox(height: 20,),

                      TextFieldWidget(
                        onTap: (){
                          _requestFocus();
                        },
                        onChangedFunc: (value){
                          setState(() {
                            mobileNoText = value;
                          });
                        },

                        focusNode: mobileFocusNode,
                        enabledColor: mobileNoText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        labelColor: mobileFocusNode.hasFocus || mobileNoText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        sufIcon: Icon(Icons.phone_android, color: mobileFocusNode.hasFocus || mobileNoText.isNotEmpty ? mainColor : mainGreyColor,),
                        inputType: TextInputType.phone,
                        validator: (value){
                          return value == null || value.isEmpty ?
                          "Enter your mobile no" : value.length < 10 ? "Enter a valid mobile no": null;
                        },
                        obscureText: false,
                        controller: _phoneController,
                        labelText: "Mobile no",
                      ),

                      const SizedBox(height: 20,),

                      TextFieldWidget(
                        onTap: (){
                          _requestFocus();
                        },
                        onChangedFunc: (value){
                          setState(() {
                            roomNoText = value;
                          });
                        },

                        focusNode: roomNoFocusNode,
                        enabledColor: roomNoText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        labelColor: roomNoFocusNode.hasFocus || roomNoText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                        sufIcon: Icon(Icons.confirmation_number_rounded, color: roomNoFocusNode.hasFocus || roomNoText.isNotEmpty ? mainColor : mainGreyColor,),
                        inputType: TextInputType.text,
                        validator: (value){
                          return value == null || value.isEmpty ?
                          "Enter your room number" : null;
                        },
                        obscureText: false,
                        controller: _roomNoController,
                        labelText: "Room number",
                      ),

                      const SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: RadioListTile(
                              activeColor: mainColor,
                              title: const Text("Male", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),),
                              value: "Male",
                              groupValue: groupValue,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                  groupValue = value.toString();
                                });
                              },
                            ),
                          ),

                          Flexible(
                            child: RadioListTile(
                              activeColor: mainColor,
                              title: const Text("Female", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),),
                              value: "Female",
                              groupValue: gender,
                              onChanged: (value){
                                setState(() {
                                  gender = value.toString();
                                  groupValue = value.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30,),

                       Center(
                            child:  Center(child: ButtonWidget(title: "Sign Up", width: 200, titleColor: Colors.white,
                              onTap: ()async{

                                if(_formKey.currentState!.validate() && gender.isNotEmpty){

                                  setState(() {
                                    loading = true;
                                  });

                                  _appLogic.signup(
                                      email: _eController.text.trim(),
                                      password: _pController.text.trim(),
                                      name: _nameController.text.trim(),
                                      phoneNo: _phoneController.text.trim(),
                                      regNo: _regNoController.text.trim(),
                                      gender: gender,
                                      roomNo: roomNoText.trim(),
                                      context: context,
                                      stopLoading: (){
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                  );


                                }else{

                                  Fluttertoast.showToast(msg: "Fill all information");

                                }
                              },
                            ))
                      ),


                      const SizedBox(height: 15,),

                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text("Already have an account? ", style: TextStyle(fontSize: 18,),),
                          InkWell(child: const Text("Login Here", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      duration: const Duration(milliseconds: 100),
                                      type: PageTransitionType.leftToRight,
                                      child: const Login()));
                            },),
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
