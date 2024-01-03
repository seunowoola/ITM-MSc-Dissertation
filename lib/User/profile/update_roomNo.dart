import 'package:flutter/material.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:hostel_management/widgets/profile_text_field.dart';



class UpdateRoomNo extends StatefulWidget {
  const UpdateRoomNo({Key? key}) : super(key: key);

  @override
  State<UpdateRoomNo> createState() => _UpdateRoomNoState();
}

class _UpdateRoomNoState extends State<UpdateRoomNo> {

  final TextEditingController _roomNoController = TextEditingController();
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
        title: const Text("Room number", style: TextStyle(color: Colors.white, fontSize: 20),),
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

                Text(UserConsts.roomNo, style: const TextStyle(fontSize: 12, color: Colors.grey),),

                const SizedBox(height: 8,),

                ProfileTextField(
                  hintText: "Enter your new room number",
                  labelText: "Room number",
                  keyboardType: TextInputType.text,
                  validator: (value){
                    return value == null || value.isEmpty ? "Enter your new room number" : null;
                  },
                  controller: _roomNoController,
                ),

                const SizedBox(height: 50,),

                Center(child: ButtonWidget(title: "Update", width: 200, titleColor: Colors.white,
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isLoading = true;
                      });

                      _appLogic.updateUserDetails(
                          field: "roomNo",
                          fieldValue: _roomNoController.text.trim().toString(),
                          context: context,
                          stopLoading: (){
                            setState(() {
                              isLoading = false;
                            });
                          }
                      );

                      setState(() {
                        UserConsts.roomNo = _roomNoController.text.trim().toString();
                      });
                      UserPreferences.setRoomNo(room: _roomNoController.text.trim().toString());
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
