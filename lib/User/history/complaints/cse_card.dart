import 'package:flutter/material.dart';
import 'package:hostel_management/User/history/complaints/complaint_details_page.dart';



class CSECard extends StatelessWidget {
  const CSECard({super.key, required this.title,this.onTap, this.color,
    required this.content, required this.date, required this.time,
    required this.appBarTitle});

  final String title;
  final Function () ? onTap;
  final Color ? color;
  final String content;
  final String date;
  final String time;
  final String appBarTitle;
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

        )));
      },
      child: SizedBox(
        height: 140,
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

                const SizedBox(height: 4,),
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
