import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/Admin/admin_home/admin_complaints/cse_card.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';


class AdminEmergencyRequest extends StatefulWidget {
  const AdminEmergencyRequest({super.key});

  @override
  State<AdminEmergencyRequest> createState() => _AdminEmergencyRequestState();
}

class _AdminEmergencyRequestState extends State<AdminEmergencyRequest> {

  final DatabaseServices _databaseServices = DatabaseServices();
  Stream? stream;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  getItem()async{
    await _databaseServices.getCSEAdmin(collectionName: "emergency").then((value){
      if(mounted){
        setState(() {
          stream = value;
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
      appBar: AppBar(title: const Text("Emergency", style: TextStyle(color: Colors.white, fontSize: 16),),
        backgroundColor: mainColor, centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.data == null ? const Center(child: CircularProgressIndicator(  valueColor: AlwaysStoppedAnimation<Color>(mainColor), strokeWidth: 6, backgroundColor: Colors.white,),)
                  : snapshot.data.docs.length == 0 ? const Center(child: Text("No item found "),) :
              ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){

                    return CSECard(
                      title: snapshot.data.docs[index].data()['emergency_title'],
                      date: snapshot.data.docs[index].data()['post_date'],
                      time: snapshot.data.docs[index].data()['post_time'],
                      content: snapshot.data.docs[index].data()['emergency_content'],
                      name: snapshot.data.docs[index].data()['username'],
                      regNo: snapshot.data.docs[index].data()['regNo'],
                      roomNo: snapshot.data.docs[index].data()['roomNo'],
                      phoneNo:snapshot.data.docs[index].data()['phoneNo'],
                      appBarTitle: "Emergency Details",
                      color: Colors.black45,
                    );


                  });
            }
        ),
      ),
    );
  }
}
