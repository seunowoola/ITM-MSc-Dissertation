import 'package:flutter/material.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:hostel_management/widgets/profile_text_field.dart';



class UpdatePhoneNo extends StatefulWidget {
  const UpdatePhoneNo({Key? key}) : super(key: key);

  @override
  State<UpdatePhoneNo> createState() => _UpdatePhoneNoState();
}

class _UpdatePhoneNoState extends State<UpdatePhoneNo> {

  final TextEditingController _phoneNoController = TextEditingController();
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
        title: const Text("Phone number", style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: mainColor, centerTitle: true,
      ),

      body: isLoading ? const LoadingIndicator() : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Form(
            key: _formKey,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(UserConsts.phoneNo, style: const TextStyle(fontSize: 12, color: Colors.grey),),

                const SizedBox(height: 8,),

                ProfileTextField(
                  hintText: "Enter your new phone number",
                  labelText: "Phone number",
                  keyboardType: TextInputType.number,
                  validator: (value){
                    return value == null || value.length != 11 ? "Enter your 11 digits phone number" : null;
                  },
                  controller: _phoneNoController,
                ),

                const SizedBox(height: 50,),

                Center(child: ButtonWidget(title: "Update", width: 200, titleColor: Colors.white,
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      isLoading = true;
                    });

                    _appLogic.updateUserDetails(
                        field: "phoneNo",
                        fieldValue: _phoneNoController.text.trim().toString(),
                        context: context,
                        stopLoading: (){
                          setState(() {
                            isLoading = false;
                          });
                        }
                    );

                    setState(() {
                      UserConsts.phoneNo = _phoneNoController.text.trim().toString();
                    });
                    UserPreferences.setUserPhoneNo(userPhoneNo: _phoneNoController.text.trim().toString());
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
