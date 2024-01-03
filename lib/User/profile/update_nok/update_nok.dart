import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/User/user_home_screen.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/navigation.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/constants/textField.dart';
import 'package:hostel_management/widgets/option_button.dart';



class UpdateNextOfKin extends StatefulWidget {
  const UpdateNextOfKin({Key? key}) : super(key: key);

  @override
  _UpdateNextOfKinState createState() => _UpdateNextOfKinState();
}

class _UpdateNextOfKinState extends State<UpdateNextOfKin> {

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode regNoFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String emailText = "";
  String nameText  = "";
  String relationshipText  = "";
  String mobileNoText = "";


  final AppLogic _appLogic = AppLogic();

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _eController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();

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
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.0,
        title: const Text("Next of kin", style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: mainColor, centerTitle: true,
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(UserConsts.nokName, style: const TextStyle(fontSize: 12, color: mainColor),),
                    const SizedBox(height: 6,),
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
                        "Enter next of kin name" : null;
                      },
                      obscureText: false,
                      controller: _nameController,
                      labelText: "Name",
                    ),
                  ],
                ),

                const SizedBox(height: 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(UserConsts.email, style: const TextStyle(fontSize: 12, color: mainColor),),
                    const SizedBox(height: 6,),
                    TextFieldWidget(
                      onTap: (){
                        _requestFocus();
                      },
                      onChangedFunc: (value){
                        setState(() {
                          emailText = value.trim();
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
                  ],
                ),

                const SizedBox(height: 20,),


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(UserConsts.nokRelationship, style: const TextStyle(fontSize: 12, color: mainColor),),
                    const SizedBox(height: 6,),
                    TextFieldWidget(
                      onTap: (){
                        _requestFocus();
                      },
                      onChangedFunc: (value){
                        setState(() {
                          relationshipText = value;
                        });
                      },

                      focusNode: regNoFocusNode,
                      enabledColor: relationshipText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                      labelColor: regNoFocusNode.hasFocus || relationshipText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                      sufIcon: Icon(Icons.family_restroom, color: regNoFocusNode.hasFocus || relationshipText.isNotEmpty ? mainColor : mainGreyColor,),
                      // inputType: TextInputType.,
                      validator: (value){
                        return value == null || value.isEmpty ?
                        "Enter your Relationship with the next of kin" : null;
                      },
                      obscureText: false,
                      controller: _relationshipController,
                      labelText: "Relationship",
                    ),
                  ],
                ),

                const SizedBox(height: 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(UserConsts.phoneNo, style: const TextStyle(fontSize: 12, color: mainColor),),
                    const SizedBox(height: 6,),
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
                      controller: _mobileNoController,
                      labelText: "Mobile no",
                    ),
                  ],
                ),

                const SizedBox(height: 20,),

                const SizedBox(height: 30,),

                Center(
                    child:  Center(child: ButtonWidget(title: "UPDATE", width: 200, titleColor: Colors.white,
                      onTap: ()async{

                        if(_formKey.currentState!.validate()){

                          setState(() {
                            loading = true;
                          });

                          _appLogic.updateNOK(
                              email: _eController.text.trim(),
                              name: _nameController.text.trim(),
                              mobileNo: _mobileNoController.text.trim(),
                              relationship: _relationshipController.text.trim(),
                              stopLoading: (){
                                setState(() {
                                  loading = false;
                                });
                              },
                              navigateFunc: (){
                                Future.delayed(const Duration(seconds: 4)).then((value) =>
                                   goBack(context, _nameController.text.trim().toString()));
                              });

                        }else{

                          Fluttertoast.showToast(msg: "Fill all information");

                        }
                      },
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
