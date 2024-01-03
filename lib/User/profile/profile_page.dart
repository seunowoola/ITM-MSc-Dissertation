import 'package:flutter/material.dart';
import 'package:hostel_management/User/profile/change_password.dart';
import 'package:hostel_management/User/profile/update_email.dart';
import 'package:hostel_management/User/profile/update_name.dart';
import 'package:hostel_management/User/profile/update_nok/update_nok.dart';
import 'package:hostel_management/User/profile/update_phone_no.dart';
import 'package:hostel_management/User/profile/update_photo.dart';
import 'package:hostel_management/User/profile/update_regNo.dart';
import 'package:hostel_management/User/profile/update_roomNo.dart';
import 'package:hostel_management/backend/app_logic.dart';
import 'package:hostel_management/backend/user_preferences.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/constants/progressIndicator.dart';
import 'package:hostel_management/widgets/option_button.dart';
import 'package:hostel_management/widgets/profile_card.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  String name = "";
  String phoneNo = "";
  String regNo = "";
  String photoUrl = "";
  String roomNo = "";

  String nokName = "";

  final AppLogic _appLogic = AppLogic();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading ? const LoadingIndicator() : Column(
          children: [
            Stack(
              alignment: const Alignment(0, 3.3),
              children: [

                Container(
                  height: 170,
                  decoration: const BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))
                  ),
                ),


                 Column(
                  children: [

                    const Text("Profile", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),),

                    const SizedBox(height: 20,),


                    UserConsts.photo.isEmpty ? GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPhotoUpdate()));
                      },
                      child: const CircleAvatar(
                        radius: 45, backgroundImage: AssetImage("assets/images/bg.png",),),
                    )
                        :
                    Container(
                      padding: const EdgeInsets.all(4), // Border width
                      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(50), // Image radius
                          child: photoUrl.isNotEmpty ?
                          InstaImageViewer(child: Image.network(photoUrl, fit: BoxFit.cover)) :
                          InstaImageViewer(child: Image.network(UserConsts.photo, fit: BoxFit.cover)),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),

            const SizedBox(height: 30,),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  shrinkWrap: true,
                  children: [

                    ProfileCard(title: "Update Profile Photo", subtitle: "",
                      onTap: ()async{
                       photoUrl = await Navigator.push(context, MaterialPageRoute(builder: (context) =>  const UserPhotoUpdate()));

                       setState(() {

                       });
                       },
                    ),

                    ProfileCard(title: name.isNotEmpty ? name : UserConsts.name, subtitle: "Full name",

                      onTap: ()async{
                        name =  await Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateName()));
                        setState(() {});
                        },
                    ),

                    ProfileCard(title: UserConsts.email, subtitle: "Email address", onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateEmailAddress()));},
                    ),


                    // Matric No
                    ProfileCard(title: UserConsts.regNo, subtitle: "Reg. No", onTap: ()async{
                      regNo  = await Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateRegNo()));},
                    ),


                    ProfileCard(title: phoneNo.isNotEmpty ? phoneNo : UserConsts.phoneNo, subtitle: "Mobile number", onTap: ()async{
                      phoneNo = await Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdatePhoneNo()));
                      setState(() {});},
                    ),

                    ProfileCard(title: roomNo.isNotEmpty ? roomNo : UserConsts.roomNo, subtitle: "Room number", onTap: ()async{
                      roomNo = await Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateRoomNo()));
                      setState(() {});},
                    ),

                    ProfileCard(title: nokName.isNotEmpty ? nokName : UserConsts.nokName, subtitle: "Next of kin", onTap: ()async{
                  nokName = await Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateNextOfKin()));
                      setState(() {});},
                    ),

                    ProfileCard(title: "*******", subtitle: "Password", onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePassword()));},
                    ),

                    const SizedBox(height: 40,),

                    // Logout
                    Center(
                      child: ButtonWidget(title: "Logout",
                        width: 200,
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
                      ),
                    ),

                  ],
                ),
              ),
            )

          ],
        )
    );
  }
}
