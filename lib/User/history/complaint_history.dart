import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/User/history/complaints/cse_card.dart';
import 'package:hostel_management/User/history/visitor/visitor_card.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';


class ComplaintHistory extends StatefulWidget {
  const ComplaintHistory({super.key});

  @override
  State<ComplaintHistory> createState() => _ComplaintHistoryState();
}

class _ComplaintHistoryState extends State<ComplaintHistory> {
  final DatabaseServices _databaseServices = DatabaseServices();
  Stream? stream;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getItem()async{
    await _databaseServices.getCSE(collectionName: "complaints", userId: _auth.currentUser!.uid,).then((value){
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
      appBar: AppBar(title: const Text("Complaints", style: TextStyle(color: Colors.white, fontSize: 16),),
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
                      title: snapshot.data.docs[index].data()['complaint_title'],
                      date: snapshot.data.docs[index].data()['post_date'],
                      time: snapshot.data.docs[index].data()['post_time'],
                      content: snapshot.data.docs[index].data()['complaint_content'],


                      appBarTitle: "Complaint Details",
                      color: Colors.pink,
                    );


                  });
            }
        ),
      ),
    );
  }
}

