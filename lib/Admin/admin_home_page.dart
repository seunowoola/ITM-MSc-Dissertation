import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_management/Admin/add_hostel_rule.dart';
import 'package:hostel_management/Admin/admin_dashboard.dart';
import 'package:hostel_management/Admin/user_list.dart';
import 'package:hostel_management/User/history/user_history_page.dart';
import 'package:hostel_management/User/profile/profile_page.dart';
import 'package:hostel_management/User/user_dashboard.dart';
import 'package:hostel_management/constants/colors.dart';




class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}


class _AdminHomePageState extends State<AdminHomePage> {


  int _selectedPageIndex = 1;
  static const List<Widget> pageOptions = <Widget>[

    UserList(),
    AdminDashboard(),
    AddHostelRules(),



  ];

  void onTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pageOptions[_selectedPageIndex],

      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items:  const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user),
                label: 'Users',
                backgroundColor: Colors.white
            ),

            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                label: 'Home',
                backgroundColor: Colors.white
            ),


            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.book),
                label: 'Hostel rules',
                backgroundColor: Colors.white
            ),



          ],
          // type: BottomNavigationBarType.shifting,
          currentIndex: _selectedPageIndex,
          selectedItemColor: buttonColors,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(color: mainColor, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
          showUnselectedLabels: true,
          iconSize: 20,
          onTap: onTapped,
          elevation: 5
      ),
    );
  }
}
