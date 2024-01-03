import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/Admin/admin_home/admin_leaves/Completed.dart';
import 'package:hostel_management/Admin/admin_home/admin_leaves/active.dart';
import 'package:hostel_management/Admin/admin_home/admin_leaves/new.dart';
import 'package:hostel_management/Admin/admin_home/admin_leaves/over_stayed.dart';
import 'package:hostel_management/Admin/admin_home/admin_leaves/rejected.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';


class AdminLeaveRequest extends StatefulWidget {
  const AdminLeaveRequest({super.key});

  @override
  State<AdminLeaveRequest> createState() => _AdminLeaveRequestState();
}

class _AdminLeaveRequestState extends State<AdminLeaveRequest> with SingleTickerProviderStateMixin {


  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20,),

              Container(
                // color: Colors.white,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _buildTabBar(),
                ),
              ),



              const SizedBox(height: 15,),

              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [

                    ActiveLeave(),
                    NewLeave(),
                    RejectedLeave(),
                    OverStayedLeave(),
                    CompletedLeave(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() => TabBar(
    controller: tabController,
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    indicator: BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.circular(10),
    ),
    labelColor: Colors.white,
    unselectedLabelColor: Colors.grey,
    isScrollable: true,
    dividerColor: Colors.transparent,
    indicatorColor: Colors.transparent,
    tabs:  const [

      Tab(
        text: '   Active    ',
      ),


      Tab(
        text: '   New    ',
      ),


      Tab(
        text: '     Rejected   ',
      ),

      Tab(
        text: '     Over Stayed     ',
      ),

      Tab(
        text: '     Completed     ',
      ),




    ],
  );
}
