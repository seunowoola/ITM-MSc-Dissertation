import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/User/history/visitor/visitor_card.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:intl/intl.dart';

class OverStayedVisitor extends StatefulWidget {
  const OverStayedVisitor({super.key});

  @override
  State<OverStayedVisitor> createState() => _OverStayedVisitorState();
}

class _OverStayedVisitorState extends State<OverStayedVisitor> {


  final DatabaseServices _databaseServices = DatabaseServices();
  Stream? visitorStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  getDate()async{

    await _databaseServices.getDocId(collectionName: "visitors", userId: _auth.currentUser!.uid).then((value) {
      for (int a = 0; a <value.docs.length; a++){
        var date1 = value.docs[a]['exit_date'].toDate();
        var date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
        var date2 = DateTime.parse(date);



        TimeOfDay now = TimeOfDay.now();
        int nowInMinutes = now.hour * 60 + now.minute;

        var local = value.docs[a]['exit_time'];
        DateTime dateTime = DateFormat("HH:mm").parse(local);
        int databaseTime = dateTime.hour * 60 + dateTime.minute;


        bool firstResult = date2.isAtSameMomentAs(date1);
        bool secondResult = date2.isAfter(date1);

        if (firstResult == true && nowInMinutes >= databaseTime && value.docs[a]['status'] != "completed"){
          //    Update to Overstayed
          _databaseServices.updateOverStayed(collectionName: "visitors",docId: value.docs[a].id, docInfo: <String, dynamic>{
            "status": "overStayed"
          });
        }else if(secondResult == true && value.docs[a]['status'] != "completed"){
          //    Update to Overstayed
          _databaseServices.updateOverStayed(collectionName: "visitors",docId: value.docs[a].id, docInfo: <String, dynamic>{
            "status": "overStayed"
          });
        }
      }

    });
  }



  getItem()async{
    await _databaseServices.getUserLeaveAndVisitorRequest(collectionName: "visitors", userId: _auth.currentUser!.uid,
        status: "overStayed").then((value){
      if(mounted){
        setState(() {
          visitorStream = value;
        });
      }
    });
  }

  @override
  void initState() {
    getDate();
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
                      color: Colors.blue,
                    );


                  });
            }
        ),
      ),
    );
  }
}
