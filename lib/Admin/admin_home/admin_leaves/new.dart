import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/Admin/admin_home/admin_leaves/leave_card.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:intl/intl.dart';

class NewLeave extends StatefulWidget {
  const NewLeave({super.key});

  @override
  State<NewLeave> createState() => _NewLeaveState();
}

class _NewLeaveState extends State<NewLeave> {

  final DatabaseServices _databaseServices = DatabaseServices();
  Stream? leaveStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getItem()async{
    await _databaseServices.getAdminLeaveAndVisitorRequest(collectionName: "leaves",
        status: "new").then((value){
      if(mounted){
        setState(() {
          leaveStream = value;
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
                      docId: snapshot.data.docs[index].id,
                      status: snapshot.data.docs[index].data()['status'],
                      name: snapshot.data.docs[index].data()['username'],
                      regNo: snapshot.data.docs[index].data()['regNo'],
                      roomNo: snapshot.data.docs[index].data()['roomNo'],
                      phoneNo:snapshot.data.docs[index].data()['phoneNo'],
                      color: Colors.green,
                    );


                  });
            }
        ),
      ),
    );
  }
}
