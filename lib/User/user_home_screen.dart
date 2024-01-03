import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hostel_management/User/history/user_history_page.dart';
import 'package:hostel_management/User/profile/profile_page.dart';
import 'package:hostel_management/User/user_dashboard.dart';
import 'package:hostel_management/constants/colors.dart';




class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}


class _UserHomePageState extends State<UserHomePage> {


  int _selectedPageIndex = 0;
  static const List<Widget> pageOptions = <Widget>[

    UserDashboard(),
    UserHistoryPage(),
    ProfilePage(),

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
                icon: Icon(FontAwesomeIcons.home),
                label: 'Home',
                backgroundColor: Colors.white
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.history),
                label: 'History',
                backgroundColor: Colors.white
            ),

            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.person),
              label: 'Profile',
              backgroundColor: Colors.white,
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
