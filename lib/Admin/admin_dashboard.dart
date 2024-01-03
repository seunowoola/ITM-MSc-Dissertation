
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:hostel_management/Admin/admin_home/admin_complaints.dart';
import 'package:hostel_management/Admin/admin_home/admin_emergency_request.dart';
import 'package:hostel_management/Admin/admin_home/admin_leave_request.dart';
import 'package:hostel_management/Admin/admin_home/admin_visitor_request.dart';
import 'package:hostel_management/Admin/admin_home/admin_suggestions.dart';
import 'package:hostel_management/Admin/hostel_rules.dart';
import 'package:hostel_management/User/dashboard/complaint.dart';
import 'package:hostel_management/User/dashboard/emergency_request.dart';
import 'package:hostel_management/User/dashboard/hostel_rules.dart';
import 'package:hostel_management/User/dashboard/leave_request.dart';
import 'package:hostel_management/User/dashboard/suggestion.dart';
import 'package:hostel_management/User/dashboard/visitor_request.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/grid.dart';
import 'package:hostel_management/widgets/home_card.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {


  List <String> titles = [
    "Leave Requests",
    "Visitor Requests",
    "Complaints",
    "Suggestions",
    "Emergency Requests",
    "Hostel Rules"
  ];

  List <Color> colors  = [
    Colors.orange,
    Colors.black87,
    Colors.purpleAccent,
    Colors.deepOrangeAccent,
    Colors.pinkAccent,
    Colors.teal,
  ];

  List<Widget> pages = [

    const AdminLeaveRequest(),
    const AdminVisitorRequest(),
    const AdminComplaints(),
    const AdminSuggestion(),
    const AdminEmergencyRequest(),
    const AdminHostelRules(),

  ];

  final AppLogic _appLogic = AppLogic();
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 0.0,
          title: const Text("Welcome, Admin", style: TextStyle(color: Colors.white, fontSize: 16,), maxLines: 1,
            overflow: TextOverflow.ellipsis,),
          backgroundColor: mainColor,
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
        body: isLoading ? const LoadingIndicator (): Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(crossAxisCount: 2,
                height: 140,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
              ),
              itemCount: pages.length,
              itemBuilder: (context, index){
                return HomeCard(title: titles[index], color: colors[index],
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => pages[index]));
                    });
              }),
        ));
  }
}
