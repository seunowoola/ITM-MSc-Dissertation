import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';


class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.name, required this.phoneNo, required this.email, required this.regNo, required this.regDate, required this.regTime,  required this.gender, required this.photo, required this.roomNo, required this.nokName, required this.nokPhoneNo, required this.nokEmail, required this.relationship}) : super(key: key);

  final String name;
  final String phoneNo;
  final String email;
  final String regNo;
  final String regDate;
  final String regTime;
  final String gender;
  final String photo;
  final String roomNo;

  final String nokName;
  final String nokPhoneNo;
  final String nokEmail;
  final String relationship;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 310,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColors,
          // color: Colors.red.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              photo.isEmpty ? Container(
                  height:80,
                  width: 80,
                  decoration:  const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(image: AssetImage("assets/images/bg.jpeg"), fit: BoxFit.cover))
              )

                  :

              Container(
                padding: const EdgeInsets.all(4), // Border width
                decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(40), // Image radius
                    child: InstaImageViewer(child: Image.network(photo, fit: BoxFit.cover)),
                  ),
                ),
              ),

              const SizedBox(width: 8,),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w600),
                      maxLines: 2, overflow: TextOverflow.ellipsis,),

                    const SizedBox(height: 4,),

                    Text("Gender: $gender", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: 4,),

                    Text("Phone No: $phoneNo", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),

                    const SizedBox(height: 4,),

                    Text("Email: $email", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis,),

                    const SizedBox(height: 4,),
                    Text("Reg No: $regNo", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),

                    const SizedBox(height: 4,),

                    Text("Reg Date: $regDate", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),

                    const SizedBox(height: 4,),

                    Text("Reg Time: $regTime", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),

                    const SizedBox(height: 4,),

                    const Divider(height: 2, color: mainColor,),

                    const SizedBox(height: 5,),

                    const Text("Next of kin", style: TextStyle(color: mainColor, fontWeight: FontWeight.w600),),

                    Text("Name: $nokName", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: 4,),

                    Text("Phone No: $nokPhoneNo", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),

                    const SizedBox(height: 4,),

                    Text("Email: $nokEmail", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis,),

                    const SizedBox(height: 4,),
                    Text("Relationship: $relationship", style: const TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis,),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}