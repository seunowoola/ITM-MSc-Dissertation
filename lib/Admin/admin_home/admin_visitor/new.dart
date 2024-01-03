import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/Admin/admin_home/admin_visitor/visitor_card.dart';
import 'package:hostel_management/User/history/leaves/leave_card.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:intl/intl.dart';

class NewVisitor extends StatefulWidget {
  const NewVisitor({super.key});

  @override
  State<NewVisitor> createState() => _NewVisitorState();
}

class _NewVisitorState extends State<NewVisitor> {

  final DatabaseServices _databaseServices = DatabaseServices();
  Stream? visitorStream;


  getItem()async{
    await _databaseServices.getAdminLeaveAndVisitorRequest(collectionName: "visitors",
        status: "new").then((value){
      if(mounted){
        setState(() {
          visitorStream = value;
        });
      }
    });
  }


  @override
  void initState() {
    getItem();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: StreamBuilder(
            stream: visitorStream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.data == null ? const Center(child: CircularProgressIndicator(  valueColor: AlwaysStoppedAnimation<Color>(mainColor), strokeWidth: 6, backgroundColor: Colors.white,),)
                  : snapshot.data.docs.length == 0 ? const Center(child: Text("No item found "),) :
              ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){

                    return VisitorCard(
                      visitorName: snapshot.data.docs[index].data()['visitor_name'],
                      arrivalDate: DateFormat("dd/MM/yyyy").format(snapshot.data.docs[index].data()['arrival_date'].toDate().toLocal()).toString(),
                      arrivalTime: snapshot.data.docs[index].data()['arrival_time'],
                      exitDate: DateFormat("dd/MM/yyyy").format(snapshot.data.docs[index].data()['exit_date'].toDate().toLocal()).toString(),
                      exitTime: snapshot.data.docs[index].data()['exit_time'],
                      purpose: snapshot.data.docs[index].data()['purpose'],
                      requestDate: snapshot.data.docs[index].data()['request_date'],
                      requestTime: snapshot.data.docs[index].data()['request_time'],
                      visitorPhoneNo: snapshot.data.docs[index].data()['visitor_phone_no'],
                      relationship: snapshot.data.docs[index].data()['relationship'],
                      docId: snapshot.data.docs[index].id,
                      name: snapshot.data.docs[index].data()['username'],
                      regNo: snapshot.data.docs[index].data()['regNo'],
                      roomNo: snapshot.data.docs[index].data()['roomNo'],
                      phoneNo:snapshot.data.docs[index].data()['phoneNo'],
                      status: snapshot.data.docs[index].data()['status'],
                      color: Colors.green,
                    );


                  });
            }
        ),
      ),
    );
  }
}
