import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:hostel_management/widgets/profile_text_field.dart';




class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  bool hidePassword1= true;
  bool hidePassword2 = true;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final AppLogic _appLogic = AppLogic();

  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.0,
        title: const Text("Password", style: TextStyle(color: Colors.white),),
        backgroundColor: mainColor, centerTitle: true,
      ),

      body: isLoading ? const LoadingIndicator() :  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children:  [

                const SizedBox(
                  height: 40,
                ),


                ProfileTextField(
                  hintText: "Password",
                  labelText: "Password (more than five characters)",
                  obscureText: hidePassword1,
                  suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          hidePassword1 = !hidePassword1;
                        });
                      },
                      child: Icon(Icons.remove_red_eye, color: !hidePassword1 ? Colors.red : Colors.grey,)),
                  validator: (value){
                    return value == null || value.length < 6 ? "Enter a valid password" : null;
                  },
                  controller: _password1Controller,
                ),

                const SizedBox(height: 50,),


                ProfileTextField(
                  hintText: "Confirm Password",
                  labelText: "Password (more than five characters)",
                  obscureText: hidePassword2,
                  suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          hidePassword2 = !hidePassword2;
                        });
                      },
                      child: Icon(Icons.remove_red_eye, color: !hidePassword2 ? Colors.red : Colors.grey,)),
                  validator: (value){
                    return value == null || value.length < 6 ? "Enter a valid password" : null;
                  },
                  controller: _password2Controller,
                ),

                const SizedBox(height: 50,),

                Center(child: ButtonWidget(title: "Update", width: 200, titleColor: Colors.white,

                  onTap: ()async{
                    if(_formKey.currentState!.validate()){
                      if(_password1Controller.text.toString().toString() ==_password2Controller.text.toString().toString()){
                        setState(() {
                          isLoading = true;
                        });

                        await _appLogic.resetPassword(newPassword: _password1Controller.text.trim().toString()).then((value)
                        =>  _appLogic.logOut(context: context, loading: (){}, stopLoading: (){}));
                      }else{
                        Fluttertoast.showToast(msg: "Password mismatch");
                      }

                    }
                  },

                  ),)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
