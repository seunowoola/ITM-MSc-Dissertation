import 'package:flutter/material.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:hostel_management/widgets/profile_text_field.dart';



class UpdateRegNo extends StatefulWidget {
  const UpdateRegNo({Key? key}) : super(key: key);

  @override
  State<UpdateRegNo> createState() => _UpdateRegNoState();
}

class _UpdateRegNoState extends State<UpdateRegNo> {

  final TextEditingController _regNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading  = false;
  final AppLogic _appLogic = AppLogic();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.0,
        title: const Text("Registration number", style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: mainColor, centerTitle: true,
      ),

      body:  isLoading ? const LoadingIndicator() : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(UserConsts.regNo, style: const TextStyle(fontSize: 12, color: Colors.grey),),

                const SizedBox(height: 8,),

                ProfileTextField(
                  hintText: "Registration No",
                  labelText: "Reg. no",
                  validator: (value){
                    return value == null || value.isEmpty ? "Enter your correct Reg no" : null;
                  },
                  controller: _regNoController,
                ),

                const SizedBox(height: 50,),

                Center(child: ButtonWidget(title: "Update", width: 200, titleColor: Colors.white,
                  onTap: (){

                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isLoading = true;
                      });

                      _appLogic.updateUserDetails(
                          field: "regNo",
                          fieldValue: _regNoController.text.trim().toString(),
                          context: context,
                          stopLoading: (){
                            setState(() {
                              isLoading = false;
                            });
                          }
                      );

                      setState(() {
                        UserConsts.regNo = _regNoController.text.trim().toString();
                      });
                      UserPreferences.setRegNo(userRegNo: _regNoController.text.trim().toString());
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
