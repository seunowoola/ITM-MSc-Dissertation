import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
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


class LeaveRequest extends StatefulWidget {
  const LeaveRequest({super.key});

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  FocusNode destinationFocusNode = FocusNode();
  FocusNode leavePurposeFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String destinationText  = "";
  String leavePurposeText  = "";


  returnBack(){
    return Navigator.pop(context);
  }

  final AppLogic _appLogic = AppLogic();

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _leavePurposeController = TextEditingController();

  final dateFormat = DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseServices _databaseServices = DatabaseServices();

  late DateTime leaveTime;
  late DateTime leaveDate;
  late DateTime returnDate;
  late DateTime returnTime;

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
      appBar: AppBar(title: const Text("Leave request", style: TextStyle(color: Colors.white, fontSize: 20),),
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
                      destinationText = value;
                    });
                  },

                  focusNode: destinationFocusNode,
                  enabledColor: destinationText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  labelColor: destinationFocusNode.hasFocus || destinationText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  sufIcon: Icon(Icons.location_on_rounded, color: destinationFocusNode.hasFocus || destinationText.isNotEmpty ? mainColor : mainGreyColor,),
                  inputType: TextInputType.text,
                  validator: (value){
                    return value == null || value.isEmpty ?
                    "Enter your destination" : null;
                  },
                  obscureText: false,
                  controller: _destinationController,
                  labelText: "Destination",
                ),

                const SizedBox(height: 20,),


               // Leave Date and Time
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   const Text("Leave date and time", style: TextStyle(color: Colors.grey, fontSize: 13),),


                   const SizedBox(height: 6,),

                   Row(
                     children: [
                       //Leave Date
                       Flexible(
                         child: DateTimeField(
                           format: dateFormat,
                           validator: (value){
                             return value == null ?
                             "Enter your leave date" : null;
                           },
                           decoration: InputDecoration(
                             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                             suffixIconColor: Colors.red,
                             hintText: "Select leave date",
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
                                   helpText: "Select your leave date",
                                   firstDate: DateTime(1900),
                                   initialDate: currentValue ?? DateTime.now(),
                                   lastDate: DateTime(2100),
                                 );

                             setState(() {
                               leaveDate = date!;
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
                             "Enter your leave time" : null;
                           },
                           decoration: InputDecoration(
                             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                             suffixIconColor: Colors.red,
                             hintText: "Select leave time",
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
                               leaveTime = ti;
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

                    const Text("Returning date and time", style: TextStyle(color: Colors.grey, fontSize: 13),),

                    const SizedBox(height: 6,),

                    Row(
                      children: [
                        //Leave Date
                        Flexible(
                          child: DateTimeField(
                            format: dateFormat,
                            validator: (value){
                              return value == null ?
                              "Enter your returning date" : null;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              suffixIconColor: Colors.red,
                              hintText: "Select returning date",
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
                                helpText: "Select your return date",
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              setState(() {
                                returnDate = date!;
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
                              "Enter your returning time" : null;
                            },

                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              suffixIconColor: Colors.red,
                              hintText: "Select returning time",
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
                                returnTime = ti;
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


                TextFieldWidget(
                  onTap: (){
                    _requestFocus();
                  },
                  onChangedFunc: (value){
                    setState(() {
                      leavePurposeText = value;
                    });
                  },

                  maxLine: 5,
                  focusNode: leavePurposeFocusNode,
                  enabledColor: leavePurposeText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  labelColor: leavePurposeFocusNode.hasFocus || leavePurposeText.isNotEmpty ? mainColor.withOpacity(0.2) : mainGreyColor,
                  // inputType: TextInputType.,
                  validator: (value){
                    return value == null || value.isEmpty ?
                    "Enter the purpose of your leave" : null;
                  },
                  obscureText: false,
                  controller: _leavePurposeController,
                  labelText: "Leave Purpose",
                ),

                const SizedBox(height: 40,),




                Center(
                    child:  Center(child: ButtonWidget(title: "Send Request", width: 200, titleColor: Colors.white,
                      onTap: ()async{

                        if(_formKey.currentState!.validate()){
                          setState(() {
                            loading = true;
                          });

                          DateTime dateTime = DateTime.now();
                          var time = DateFormat.jm().format(dateTime);
                          var date = DateFormat("dd/MM/yyyy").format(dateTime).toString();
                          var orderingDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime).toString();

                          var lt = DateFormat.Hm().format(leaveTime);
                          var rt = DateFormat.Hm().format(returnTime);

                          await _databaseServices.addRequests(
                              collectionName: "leaves",
                              itemDetails: <String, dynamic>{

                                "destination": destinationText,
                                "leaveDate": leaveDate,
                                "leaveTime": lt,
                                "returningDate": returnDate,
                                "returningTime": rt,
                                "request_date": date,
                                "request_time": time,
                                "ordering_date": orderingDate,
                                "uid": _auth.currentUser!.uid,
                                "username": UserConsts.name,
                                "userPhoto": UserConsts.photo,
                                "status": "new",
                                "nexOfKinName": UserConsts.nokName,
                                "nexOfKinEmail": UserConsts.nokEmail,
                                "nexOfKinPhoneNo": UserConsts.nokPhoneNo,
                                "purpose": leavePurposeText,
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
