import 'package:flutter/material.dart';
import 'package:hostel_management/User/history/leaves/Completed.dart';
import 'package:hostel_management/User/history/leaves/active.dart';
import 'package:hostel_management/User/history/leaves/over_stayed.dart';
import 'package:hostel_management/User/history/leaves/pending.dart';
import 'package:hostel_management/User/history/leaves/rejected.dart';
import 'package:hostel_management/constants/colors.dart';


class LeaveRequestHistory extends StatefulWidget {
  const LeaveRequestHistory({super.key});

  @override
  State<LeaveRequestHistory> createState() => _LeaveRequestHistoryState();
}

class _LeaveRequestHistoryState extends State<LeaveRequestHistory> with SingleTickerProviderStateMixin {


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
                    PendingLeave(),
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
        text: '     Pending   ',
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
