import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';



class HostelRules extends StatefulWidget {
  const HostelRules({super.key});

  @override
  State<HostelRules> createState() => _HostelRulesState();
}

class _HostelRulesState extends State<HostelRules> {


  final DatabaseServices _databaseServices = DatabaseServices();
  Stream? stream;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getItem()async{
    await _databaseServices.getHostelRule(collectionName: "hostelRules").then((value){
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
      appBar: AppBar(title: const Text("Hostel Rules", style: TextStyle(color: Colors.white, fontSize: 16),),
        backgroundColor: mainColor, centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.data == null ? const Center(child: CircularProgressIndicator(  valueColor: AlwaysStoppedAnimation<Color>(mainColor), strokeWidth: 6, backgroundColor: Colors.white,),)
                  : snapshot.data.docs.length == 0 ? const Center(child: Text("No item found "),) :
              ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    return Text(snapshot.data.docs[index].data()['content']);

                  });
            }
        ),
      ),
    );
  }
}
