import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';


class LeaveDetailsPage extends StatefulWidget {
  const LeaveDetailsPage({super.key, required this.leaveDate, required this.leaveTime, required this.purpose, required this.returnDate, required this.returnTime, required this.destination, required this.requestDate, required this.requestTime, this.returnedDate, this.returnedTime});
  final String leaveDate;
  final String leaveTime;
  final String purpose;
  final String returnDate;
  final String returnTime;
  final String destination;
  final String requestDate;
  final String requestTime;
  final String ? returnedDate;
  final String ? returnedTime;

  @override
  State<LeaveDetailsPage> createState() => _LeaveDetailsPageState();
}

class _LeaveDetailsPageState extends State<LeaveDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Details",
        style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: mainColor, centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text("Destination: ${widget.destination}"),

            const SizedBox(height: 8,),

            Row(
              children: [

                 Text(
                  "Request Date: ${widget.requestDate}",
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(width: 5,),
                Container(color: Colors.red, height: 12, width: 2,),
                const SizedBox(width: 5,),

                 Text(
                  "Time: ${widget.requestTime}",
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(height: 8,),

            Row(
              children: [
                 Text(
                  "Leave Date: ${widget.leaveDate}",
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(width: 5,),
                Container(color: Colors.red, height: 12, width: 2,),
                const SizedBox(width: 5,),

                 Text(
                  "Time: ${widget.leaveTime}",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(height: 8,),

            Row(
              children: [
                 Text(
                  "Returning Date: ${widget.returnDate}",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(width: 5,),
                Container(color: Colors.red, height: 12, width: 2,),
                const SizedBox(width: 5,),

                 Text(
                  "Time: ${widget.returnTime}",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(height: 8,),

           widget.returnedDate != null  ? Row(
              children: [
                 Text(
                  "Returned Date: ${widget.returnedDate}",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(width: 5,),
                Container(color: Colors.red, height: 12, width: 2,),
                const SizedBox(width: 5,),

                 Text(
                  "Time: ${widget.returnedTime}",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),

              ],
            ): const SizedBox(),

            const SizedBox(height: 8,),


            const Divider(color: mainColor, thickness: 0.5,),

             Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "Leave Purpose:\n${widget.purpose}",
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
