
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:hostel_management/widgets/profile_text_field.dart';



class UpdateEmailAddress extends StatefulWidget {
  const UpdateEmailAddress({Key? key}) : super(key: key);

  @override
  State<UpdateEmailAddress> createState() => _UpdateEmailAddressState();
}

class _UpdateEmailAddressState extends State<UpdateEmailAddress> {


  final _formKey = GlobalKey<FormState>();
  bool isLoading  = false;
  final AppLogic _appLogic = AppLogic();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.0,
        title: const Text("Email", style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: mainColor, centerTitle: true,
      ),

      body: isLoading ? const LoadingIndicator() : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(UserConsts.email, style: const TextStyle(fontSize: 12, color: Colors.grey),),

                const SizedBox(height: 8,),

                ProfileTextField(
                  hintText: "Enter your next of kin email",
                  labelText: "Email",
                  validator: (value){
                    final bool isValid = EmailValidator.validate(value!);
                    return !isValid ? "Enter valid email" : null;
                  },
                  controller: _emailController,
                ),

                const SizedBox(height: 50,),

                Center(child: ButtonWidget(title: "Update", width: 200,
                  titleColor: Colors.white,
                onTap: ()async{
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      isLoading = true;
                    });

                    await _appLogic.resetEmail(
                        newEmail: _emailController.text.trim().toString(),).then((value) {

                            _appLogic.updateUserDetails(
                              field: "email",
                              fieldValue: _emailController.text.trim().toString(),
                              context: context,
                              stopLoading: (){
                                setState(() {
                                  isLoading = false;
                                });
                              }
                          );
                            _appLogic.logOut(context: context, loading: (){}, stopLoading: (){});
                    });



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
