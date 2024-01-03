import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/User/history/leaves/leave_card.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:intl/intl.dart';

class OverStayedLeave extends StatefulWidget {
  const OverStayedLeave({super.key});

  @override
  State<OverStayedLeave> createState() => _OverStayedLeaveState();
}

class _OverStayedLeaveState extends State<OverStayedLeave> {


  final DatabaseServices _databaseServices = DatabaseServices();
  Stream? leaveStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  getDate()async{

    await _databaseServices.getDocId(collectionName: "leaves", userId: _auth.currentUser!.uid).then((value) {
      for (int a = 0; a <value.docs.length; a++){
        var date1 = value.docs[a]['returningDate'].toDate();
        var date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
        var date2 = DateTime.parse(date);



        TimeOfDay now = TimeOfDay.now();
        int nowInMinutes = now.hour * 60 + now.minute;

        var local = value.docs[a]['returningTime'];
        DateTime dateTime = DateFormat("HH:mm").parse(local);
        int databaseTime = dateTime.hour * 60 + dateTime.minute;


        bool firstResult = date2.isAtSameMomentAs(date1);
        bool secondResult = date2.isAfter(date1);

        if (firstResult == true && nowInMinutes >= databaseTime && value.docs[a]['status'] != "completed"){
          //    Update to Overstayed
          _databaseServices.updateOverStayed(collectionName: "leaves", docId: value.docs[a].id, docInfo: <String, dynamic>{
            "status": "overStayed"
          });
        }else if(secondResult == true && value.docs[a]['status'] != "completed"){
          //    Update to Overstayed
          _databaseServices.updateOverStayed(collectionName: "leaves", docId: value.docs[a].id, docInfo: <String, dynamic>{
            "status": "overStayed"
          });
        }
      }

    });
  }



  getItem()async{
    await _databaseServices.getUserLeaveAndVisitorRequest(collectionName: "leaves",userId: _auth.currentUser!.uid,
        status: "overStayed").then((value){
      if(mounted){
        setState(() {
          leaveStream = value;
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
            stream: leaveStream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.data == null ? const Center(child: CircularProgressIndicator(  valueColor: AlwaysStoppedAnimation<Color>(mainColor), strokeWidth: 6, backgroundColor: Colors.white,),)
                  : snapshot.data.docs.length == 0 ? const Center(child: Text("No item found "),) :
              ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    return LeaveCard(
                      destination: snapshot.data.docs[index].data()['destination'],
                      leaveDate: DateFormat("dd/MM/yyyy").format(snapshot.data.docs[index].data()['leaveDate'].toDate().toLocal()).toString(),
                      leaveTime: snapshot.data.docs[index].data()['leaveTime'],
                      returnDate: DateFormat("dd/MM/yyyy").format(snapshot.data.docs[index].data()['returningDate'].toDate().toLocal()).toString(),
                      returnTime: snapshot.data.docs[index].data()['returningTime'],
                      purpose: snapshot.data.docs[index].data()['purpose'],
                      requestDate: snapshot.data.docs[index].data()['request_date'],
                      requestTime: snapshot.data.docs[index].data()['request_time'],
                      color: Colors.black87,
                    );
                  });
            }
        ),
      ),
    );
  }
}
