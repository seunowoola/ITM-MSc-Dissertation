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


class EmergencyRequest extends StatefulWidget {
  const EmergencyRequest({super.key});

  @override
  State<EmergencyRequest> createState() => _EmergencyRequestState();
}

class _EmergencyRequestState extends State<EmergencyRequest> {
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String titleText  = "";
  String contentText  = "";



  final AppLogic _appLogic = AppLogic();

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();


  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseServices _databaseServices = DatabaseServices();

  returnBack(){
    return Navigator.pop(context);
  }

  void _requestFocus(){
    setState(() {
      FocusScope.of(context).requestFocus();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(title: const Text("Emergency request", style: TextStyle(color: Colors.white, fontSize: 20),),
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
                      titleText = value;
                    });
                  },

                  focusNode: titleFocusNode,
                  enabledColor: titleText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  labelColor: titleFocusNode.hasFocus || titleText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  inputType: TextInputType.text,
                  validator: (value){
                    return value == null || value.isEmpty ?
                    "Enter the nature of the emergency" : null;
                  },
                  obscureText: false,
                  controller: _titleController,
                  labelText: "Title",
                ),

                const SizedBox(height: 20,),


                const SizedBox(height: 20,),


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
                    "Enter the content of the request" : null;
                  },
                  obscureText: false,
                  controller: _contentController,
                  labelText: "Content",
                ),

                const SizedBox(height: 50,),




                Center(
                    child:  Center(child: ButtonWidget(title: "Send", width: 200, titleColor: Colors.white,
                        onTap: ()async{

                          if(_formKey.currentState!.validate()){
                            setState(() {
                              loading = true;
                            });

                            DateTime dateTime = DateTime.now();
                            var time = DateFormat.jm().format(dateTime);
                            var date = DateFormat("dd/MM/yyyy").format(dateTime).toString();
                            var orderingDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime).toString();

                            await _databaseServices.addRequests(
                                collectionName: "emergency",
                                itemDetails: <String, dynamic>{

                                  "emergency_title": titleText,
                                  "emergency_content": contentText,
                                  "post_date": date,
                                  "post_time": time,
                                  "ordering_date": orderingDate,
                                  "uid": _auth.currentUser!.uid,
                                  "username": UserConsts.name,
                                  "userPhoto": UserConsts.photo,
                                  "regNo": UserConsts.regNo,
                                  "phoneNo":UserConsts.phoneNo,
                                  "roomNo":UserConsts.roomNo,
                                }

                            );

                            setState(() {
                              loading = false;
                            });


                            Fluttertoast.showToast(msg: "Request sent");
                            returnBack();
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
