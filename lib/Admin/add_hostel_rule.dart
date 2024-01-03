import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/constants/textField.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:intl/intl.dart';


class AddHostelRules extends StatefulWidget {
  const AddHostelRules({super.key});

  @override
  State<AddHostelRules> createState() => _AddHostelRulesState();
}

class _AddHostelRulesState extends State<AddHostelRules> {
   FocusNode contentFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String contentText  = "";


  final DatabaseServices _databaseServices = DatabaseServices();


  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _contentController = TextEditingController();


  bool loading = false;

  void _requestFocus(){
    setState(() {
      FocusScope.of(context).requestFocus();
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(title: const Text("Hostel Rules", style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: mainColor, centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: loading ? const LoadingIndicator() : GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView(
              shrinkWrap: true,
              children: [

                const SizedBox(height: 50,),



                TextFieldWidget(
                  onTap: (){
                    _requestFocus();
                  },
                  onChangedFunc: (value){
                    setState(() {
                      contentText = value;
                    });
                  },

                  maxLine: 5,
                  focusNode: contentFocusNode,
                  enabledColor: contentText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  labelColor: contentFocusNode.hasFocus || contentText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  // inputType: TextInputType.,
                  validator: (value){
                    return value == null || value.isEmpty ?
                    "Enter the hostel rules" : null;
                  },
                  obscureText: false,
                  controller: _contentController,
                  labelText: "Hostel rules",
                ),

                const SizedBox(height: 50,),


                Center(
                    child:  Center(child: ButtonWidget(title: "Post", width: 200, titleColor: Colors.white,
                        onTap: ()async{

                          if(_formKey.currentState!.validate()){
                            setState(() {
                              loading = true;
                            });

                            await _databaseServices.addHostelRules(
                                rules: <String, dynamic>{
                                  "content": contentText,
                                }

                            );

                            setState(() {
                              loading = false;
                            });


                            Fluttertoast.showToast(msg: "Successfully posted");
                            _contentController.clear();
                          }else{
                            Fluttertoast.showToast(msg: "Fill all information");
                          }


                        }
                    ))
                ),

                const SizedBox(height: 15,),

              ],
            ),
          ),
        ),

      ),

    );

  }
}
