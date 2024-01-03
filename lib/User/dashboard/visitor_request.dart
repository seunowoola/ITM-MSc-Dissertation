import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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



class VisitorRequest extends StatefulWidget {
  const VisitorRequest({Key? key}) : super(key: key);

  @override
  _VisitorRequestState createState() => _VisitorRequestState();
}

class _VisitorRequestState extends State<VisitorRequest> {

  FocusNode purposeFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode relationshipNoFocusNode = FocusNode();
  FocusNode mobileFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String purposeText = "";
  String nameText  = "";
  String relationshipText  = "";
  String mobileNoText = "";

  late DateTime arrivalTime;
  late DateTime arrivalDate;
  late DateTime exitDate;
  late DateTime exitTime;

  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm");


  returnBack(){
    return Navigator.pop(context);
  }

  final AppLogic _appLogic = AppLogic();

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _relationshipController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();

  bool loading = false;

  String gender = "";
  String groupValue = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseServices _databaseServices = DatabaseServices();

  void _requestFocus(){
    setState(() {
      FocusScope.of(context).requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: AppBar(title: const Text("Visitor Request", style: TextStyle(color: Colors.white, fontSize: 20),),
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

                const SizedBox(height: 30,),

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
                    "Enter your visitor's name" : null;
                  },
                  obscureText: false,
                  controller: _nameController,
                  labelText: "Visitor's name",
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
                    "Enter your visitor's mobile no" : value.length < 10 ? "Enter a valid mobile no": null;
                  },
                  obscureText: false,
                  controller: _mobileNoController,
                  labelText: "Visitor's Mobile no",
                ),

                const SizedBox(height: 20,),


                TextFieldWidget(
                  onTap: (){
                    _requestFocus();
                  },
                  onChangedFunc: (value){
                    setState(() {
                      relationshipText = value;
                    });
                  },

                  focusNode: relationshipNoFocusNode,
                  enabledColor: relationshipText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  labelColor: relationshipNoFocusNode.hasFocus || relationshipText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  // inputType: TextInputType.,
                  validator: (value){
                    return value == null || value.isEmpty ?
                    "Enter your Relationship with the visitor" : null;
                  },
                  obscureText: false,
                  controller: _relationshipController,
                  labelText: "Relationship with the visitor",
                ),

                const SizedBox(height: 20,),


                // Arrival Date and Time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text("Arrival date and time", style: TextStyle(color: Colors.grey, fontSize: 13),),


                    const SizedBox(height: 6,),

                    Row(
                      children: [
                        //Leave Date
                        Flexible(
                          child: DateTimeField(
                            format: dateFormat,
                            validator: (value){
                              return value == null ?
                              "Enter your visitor's arrival date" : null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              suffixIconColor: Colors.red,
                              hintText: "Select arrival date",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:   BorderSide(color: mainColor.withOpacity(0.2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
                              ),
                              focusedErrorBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),

                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onShowPicker: (context, currentValue) async{
                              final date  = await showDatePicker(
                                context: context,
                                helpText: "Select your arrival date",
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              setState(() {
                                arrivalDate = date!;
                              });

                              return date;
                            },
                          ),
                        ),

                        const SizedBox(width: 6,),

                        // Leave Time
                        Flexible(
                          child: DateTimeField(
                            format: timeFormat,
                            validator: (value){
                              return value == null ?
                              "Enter your arrival time" : null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              suffixIconColor: Colors.red,
                              hintText: "Select arrival time",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:  BorderSide(color: mainColor.withOpacity(0.2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
                              ),
                              focusedErrorBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),

                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialEntryMode: TimePickerEntryMode.inputOnly,
                                helpText: "Enter time",
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                              );

                              DateTime ti = DateTimeField.convert(time)!;

                              setState(() {
                                arrivalTime = ti;
                              });

                              return DateTimeField.convert(time);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20,),

                // Returning Date and Time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text("Exit date and time", style: TextStyle(color: Colors.grey, fontSize: 13),),

                    const SizedBox(height: 6,),

                    Row(
                      children: [
                        //Leave Date
                        Flexible(
                          child: DateTimeField(
                            format: dateFormat,
                            validator: (value){
                              return value == null ?
                              "Enter your visitor's exit date" : null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              suffixIconColor: Colors.red,
                              hintText: "Select exit date",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:   BorderSide(color: mainColor.withOpacity(0.2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
                              ),
                              focusedErrorBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),

                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onShowPicker: (context, currentValue) async{
                              final date  = await showDatePicker(
                                context: context,
                                helpText: "Select your visitor's exit date",
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              setState(() {
                                exitDate = date!;
                              });

                              return date;
                            },
                          ),
                        ),

                        const SizedBox(width: 6,),

                        // Leave Time
                        Flexible(
                          child: DateTimeField(
                            format: timeFormat,
                            validator: (value){
                              return value == null ?
                              "Enter your visitor's exit time" : null;
                            },

                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              suffixIconColor: Colors.red,
                              hintText: "Select exit time",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:  BorderSide(color: mainColor.withOpacity(0.2)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
                              ),
                              focusedErrorBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),

                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialEntryMode: TimePickerEntryMode.inputOnly,
                                helpText: "Enter time",
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                              );

                              DateTime ti = DateTimeField.convert(time)!;

                              setState(() {
                                exitTime = ti;
                              });

                              return DateTimeField.convert(time);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),


                const SizedBox(height: 20,),

                const Text("Visitor's Gender"),

                const SizedBox(height: 6,),
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
                const SizedBox(height: 20,),

                TextFieldWidget(
                  onTap: (){
                    _requestFocus();
                  },
                  onChangedFunc: (value){
                    setState(() {
                      purposeText = value;
                    });
                  },

                  maxLine: 5,
                  focusNode: purposeFocusNode,
                  enabledColor: purposeText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  labelColor: purposeFocusNode.hasFocus || purposeText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  inputType: TextInputType.text,
                  validator: (value){
                    return value == null || value.isEmpty ?
                    "Enter visiting purpose" : null;
                  },
                  obscureText: false,
                  controller: _purposeController,
                  labelText: "Purpose of visit",
                ),

                const SizedBox(height: 20,),


                Center(
                    child:  Center(child: ButtonWidget(title: "Send Request", width: 200, titleColor: Colors.white,
                        onTap: ()async{

                          if(_formKey.currentState!.validate() && gender.isNotEmpty){
                            setState(() {
                              loading = true;
                            });

                            DateTime dateTime = DateTime.now();
                            var time = DateFormat.jm().format(dateTime);
                            var date = DateFormat("dd/MM/yyyy").format(dateTime).toString();
                            var orderingDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime).toString();

                            var at = DateFormat.Hm().format(arrivalTime);
                            var et = DateFormat.Hm().format(exitTime);

                            await _databaseServices.addRequests(
                                collectionName: "visitors",
                                itemDetails: <String, dynamic>{

                                  "visitor_name": nameText,
                                  "visitor_phone_no": mobileNoText,
                                  "relationship": relationshipText,
                                  "arrival_date": arrivalDate,
                                  "arrival_time": at,
                                  "exit_date": exitDate,
                                  "exit_time": et,
                                  "request_date": date,
                                  "request_time": time,
                                  "ordering_date": orderingDate,
                                  "uid": _auth.currentUser!.uid,
                                  "username": UserConsts.name,
                                  "userPhoto": UserConsts.photo,
                                  "status": "new",
                                  "purpose": purposeText,
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
