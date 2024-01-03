import 'package:flutter/material.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:hostel_management/widgets/profile_text_field.dart';



class UpdateName extends StatefulWidget {
  const UpdateName({Key? key}) : super(key: key);

  @override
  State<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends State<UpdateName> {

  final TextEditingController _nameController = TextEditingController();
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
        title: const Text("Full name", style: TextStyle(color: Colors.white, fontSize: 20),),
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

                Text(UserConsts.name, style: const TextStyle(fontSize: 12, color: Colors.grey),),

                const SizedBox(height: 8,),

                ProfileTextField(
                  hintText: "Enter your new name",
                  labelText: "Name",
                  validator: (value){
                    return value == null || value.isEmpty ? "Enter your new name" : null;
                  },
                  controller: _nameController,
                ),

                const SizedBox(height: 50,),

                 Center(child: ButtonWidget(title: "Update", width: 200, titleColor: Colors.white,
                onTap: (){

                  if(_formKey.currentState!.validate()){
                    setState(() {
                      isLoading = true;
                    });

                    _appLogic.updateUserDetails(
                        field: "name",
                        fieldValue: _nameController.text.trim().toString(),
                        context: context,
                        stopLoading: (){
                          setState(() {
                            isLoading = false;
                          });
                        }
                    );

                    setState(() {
                      UserConsts.name = _nameController.text.trim().toString();
                    });
                    UserPreferences.setUserName(userName: _nameController.text.trim().toString());
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
