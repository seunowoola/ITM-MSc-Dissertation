import 'package:flutter/material.dart';
import 'package:hostel_management/Admin/user_card.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';



class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  final DatabaseServices _databaseServices = DatabaseServices();
  Stream? allUsers;


  getAllUsers()async{
    await _databaseServices.getAllUsers().then((value){
      if(mounted){
        setState(() {
          allUsers = value;
        });
      }
    });
  }

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  final AppLogic _appLogic = AppLogic();
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        title: const Text("Welcome, Admin", style: TextStyle(fontSize: 16, color: Colors.white),),


        actions: [
          GestureDetector(
            onTap: (){
              _appLogic.logOut(context: context, loading: (){
                setState(() {
                  isLoading = true;
                });
              }, stopLoading: (){
                setState(() {
                  isLoading = false;
                });
              });
            },

            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.logout, color: Colors.white, size: 25,),
            ),
          ),
        ],
      ),


      body: isLoading ? const LoadingIndicator(): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StreamBuilder(
            stream: allUsers,
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.data == null ? const Center(child: CircularProgressIndicator(  valueColor: AlwaysStoppedAnimation<Color>(mainColor), strokeWidth: 6, backgroundColor: Colors.white,),)
                  :
              ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    return UserCard(
                      name: snapshot.data.docs[index].data()['name'],
                      email: snapshot.data.docs[index].data()['email'],
                      phoneNo: snapshot.data.docs[index].data()['phoneNo'],
                      regTime: snapshot.data.docs[index].data()['register_time'],
                      regDate: snapshot.data.docs[index].data()['register_date'],
                      regNo: snapshot.data.docs[index].data()['regNo'],
                      photo: snapshot.data.docs[index].data()['photo'],
                      gender: snapshot.data.docs[index].data()['gender'],
                      nokName: snapshot.data.docs[index].data()['nextOfKinName'],
                      nokEmail: snapshot.data.docs[index].data()['nextOfKinEmail'],
                      nokPhoneNo: snapshot.data.docs[index].data()['nextOfKinPhoneNo'],
                      relationship: snapshot.data.docs[index].data()['relationship'],
                      roomNo: snapshot.data.docs[index].data()['roomNo'],
                    );

                  });
            }),

      ),
    );
  }
}
