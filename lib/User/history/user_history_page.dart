import 'package:flutter/material.dart';
import 'package:hostel_management/User/history/complaint_history.dart';
import 'package:hostel_management/User/history/emergency_request_history.dart';
import 'package:hostel_management/User/history/history_card.dart';
import 'package:hostel_management/User/history/leave_request_history.dart';
import 'package:hostel_management/User/history/suggestions.dart';
import 'package:hostel_management/User/history/visitor_request_history.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/constants/colors.dart';

class UserHistoryPage extends StatefulWidget {
  const UserHistoryPage({super.key});

  @override
  State<UserHistoryPage> createState() => _UserHistoryPageState();
}

class _UserHistoryPageState extends State<UserHistoryPage> {


  List <String> titles = [
    "Leave Requests",
    "Visitor Requests",
    "Complaints",
    "Suggestions",
    "Emergency Requests",
  ];

  List <Color> colors  = [

    Colors.redAccent,
    Colors.orange,
    Colors.black,
    Colors.brown,
    Colors.pink,

  ];

  final List<Widget> _pages = [

    const LeaveRequestHistory(),
    const VisitorRequestHistory(),
    const ComplaintHistory(),
    const SuggestionHistory(),
    const EmergencyRequestHistory(),

  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.0,
        centerTitle: true,
        title: const Text("History", style: TextStyle(color: Colors.white, fontSize: 20,), maxLines: 1,
          overflow: TextOverflow.ellipsis,),
        backgroundColor: mainColor,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.builder(
            itemCount: _pages.length,
            itemBuilder: (context, index){
              return HistoryCard(title: titles[index], color: colors[index],
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => _pages[index]));
                  });
            }),
      ),

    );
  }
}
