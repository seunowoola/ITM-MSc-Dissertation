import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';


class CommonDetailsPage extends StatefulWidget {
  const CommonDetailsPage({super.key, required this.date, required this.time, required this.title, required this.content, required this.appBarTitle, required this.name, required this.regNo, required this.roomNo, required this.phoneNo});

  final String date;
  final String time;
  final String title;
  final String content;
  final String appBarTitle;
  final String name;
  final String regNo;
  final String roomNo;
  final String phoneNo;
  @override
  State<CommonDetailsPage> createState() => _CommonDetailsPageState();
}

class _CommonDetailsPageState extends State<CommonDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(widget.appBarTitle,
        style: const TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: mainColor, centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${widget.name}"),
            const SizedBox(height: 8,),
            Text("Phone no: ${widget.phoneNo}"),
            const SizedBox(height: 8,),
            Text("Reg. no: ${widget.regNo}"),
            const SizedBox(height: 8,),
            Text("Room no: ${widget.roomNo}"),

            const SizedBox(height: 8,),

            Text("Date: ${widget.date}"),

            const SizedBox(height: 8,),

            Text(
              "Time: ${widget.time}",
              style: const TextStyle(
                  fontSize: 14, color: Colors.black),maxLines: 1, overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8,),

            Text(
              "Complaint title: ${widget.title}",
              style: const TextStyle(
                  fontSize: 14, color: Colors.black),maxLines: 2, overflow: TextOverflow.ellipsis,
            ),


            Divider(color: mainColor, thickness: 0.5,),

            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "Content:\n${widget.content}",
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black, wordSpacing: 1),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
