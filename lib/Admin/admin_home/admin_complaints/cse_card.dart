import 'package:flutter/material.dart';
import 'package:hostel_management/Admin/admin_home/admin_complaints/complaint_details_page.dart';


class CSECard extends StatelessWidget {
  const CSECard({super.key, required this.title,this.onTap, this.color, required this.content, required this.date, required this.time, required this.appBarTitle, required this.name, required this.regNo, required this.roomNo, required this.phoneNo});

  final String title;
  final Function () ? onTap;
  final Color ? color;
  final String content;
  final String date;
  final String time;
  final String appBarTitle;
  final String name;
  final String regNo;
  final String roomNo;
  final String phoneNo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CommonDetailsPage(
          title: title,
          content: content,
          date: date,
          time: time,
          appBarTitle: appBarTitle,
          name: name,
          phoneNo: phoneNo,
          regNo: regNo,
          roomNo: roomNo,
        )));
      },
      child: SizedBox(
        height: 190,
        child: Card(
          color: color ?? Colors.grey,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: $name",
                  style: const TextStyle(
                    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4,),

                Text(
                  "Reg. no: $regNo",
                  style: const TextStyle(
                    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),


                const SizedBox(height: 4,),

                Text(
                  "Room. no: $roomNo",
                  style: const TextStyle(
                    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Text(
                      "Date: $date",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.white),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(width: 5,),
                    Container(color: Colors.red, height: 12, width: 2,),
                    const SizedBox(width: 5,),

                    Text(
                      "Time: $time",
                      style: const TextStyle(
                        fontSize: 14, color: Colors.white,),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                const SizedBox(height: 4,),

                Text(
                  "Title: $title",
                  style: const TextStyle(
                    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),


                const SizedBox(height: 4,),

                 Text(
                  "Content: $content",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.white, ),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
