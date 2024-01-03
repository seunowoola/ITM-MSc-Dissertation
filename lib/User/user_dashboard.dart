
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:hostel_management/User/dashboard/complaint.dart';
import 'package:hostel_management/User/dashboard/emergency_request.dart';
import 'package:hostel_management/User/dashboard/hostel_rules.dart';
import 'package:hostel_management/User/dashboard/leave_request.dart';
import 'package:hostel_management/User/dashboard/suggestion.dart';
import 'package:hostel_management/User/dashboard/visitor_request.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/backend/user_shared_preference.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/widgets/grid.dart';
import 'package:hostel_management/widgets/home_card.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  List<CarouselItem> itemList = [
  CarouselItem(image: const AssetImage("assets/images/s1.jpg")),
  CarouselItem(image: const AssetImage("assets/images/s3.jpg")),
  CarouselItem(image: const AssetImage("assets/images/s4.jpg")),
  CarouselItem(image: const AssetImage("assets/images/s5.jpg")),
  CarouselItem(image: const AssetImage("assets/images/s6.jpg")),
  ];

  List <String> titles = [
    "Leave Request",
    "Visitor Request",
    "Complaint",
    "Suggestion",
    "Emergency Request",
    "Hostel Rules"
  ];

  List <Color> colors  = [
    Colors.red,
    Colors.green,
    Colors.indigoAccent,
    Colors.deepOrangeAccent,
    Colors.black87,
    Colors.orange,
  ];

  List<Widget> pages = [

    const LeaveRequest(),
    const VisitorRequest(),
    const Complaint(),
    const Suggestion(),
    const EmergencyRequest(),
    const HostelRules(),

  ];

  getPreferences() async {

    UserConsts.name = await UserPreferences.getUserName();
    UserConsts.email = await UserPreferences.getUserEmail();
    UserConsts.gender = await UserPreferences.getUserGender();
    UserConsts.phoneNo = await UserPreferences.getUserPhoneNo();
    UserConsts.photo = await UserPreferences.getProfilePhoto();
    UserConsts.regNo = await UserPreferences.getMatricNo();
    UserConsts.roomNo = await UserPreferences.getRoomNo();

    UserConsts.nokName = await UserPreferences.getNokName();
    UserConsts.nokEmail = await UserPreferences.getNokEmail();
    UserConsts.nokRelationship = await UserPreferences.getNokRelationship();
    UserConsts.nokPhoneNo = await UserPreferences.getNokMobileNo();




    if (mounted) {
      setState(() {});
    }
  }


  void runAllInit()async{
    await getPreferences();
  }

  @override
  void initState() {
    super.initState();
    runAllInit();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          elevation: 0.0,
          title: Text("Welcome, ${UserConsts.name}", style: const TextStyle(color: Colors.white, fontSize: 16,), maxLines: 1,
          overflow: TextOverflow.ellipsis,),
          backgroundColor: mainColor,
        ),
      body: Column(
        children: [
          CustomCarouselSlider(
            items: itemList,
            height: 150,
            subHeight: 50,
            autoplay: true,
            showText: false,
            showSubBackground: false,
            indicatorShape: BoxShape.circle,
            selectedDotColor: mainColor,
            unselectedDotColor: Colors.grey,
          ),

          const SizedBox(height: 10,),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            ),
          ),
        ],
      ));
  }
}
