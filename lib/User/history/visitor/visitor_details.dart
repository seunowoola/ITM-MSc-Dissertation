import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';


class VisitorDetailsPage extends StatefulWidget {
  const VisitorDetailsPage({super.key, required this.visitorName, required this.visitorPhoneNo, required this.requestDate, required this.requestTime, required this.purpose, required this.relationship, required this.extDate, required this.extTime, required this.arrivalDate, required this.arrivalTime});

  final String visitorName;
  final String visitorPhoneNo;
  final String requestDate;
  final String requestTime;
  final String purpose;
  final String relationship;
  final String extDate;
  final String extTime;
  final String arrivalDate;
  final String arrivalTime;

  @override
  State<VisitorDetailsPage> createState() => _VisitorDetailsPageState();
}

class _VisitorDetailsPageState extends State<VisitorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visitor Details",
        style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: mainColor, centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Visitor's name: ${widget.visitorName}"),

            const SizedBox(height: 8,),

            Text("Visitor's phone no: ${widget.visitorPhoneNo}"),

            const SizedBox(height: 8,),

            Text("Relationship: ${widget.visitorPhoneNo}"),

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
                  "Visiting date: ${widget.arrivalDate}",
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(width: 5,),
                Container(color: Colors.red, height: 12, width: 2,),
                const SizedBox(width: 5,),

                Text(
                  "Arrival time: ${widget.arrivalTime}",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(height: 8,),

            Row(
              children: [
                Text(
                  "Exit Date: ${widget.extDate}",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(width: 5,),
                Container(color: Colors.red, height: 12, width: 2,),
                const SizedBox(width: 5,),

                Text(
                  "Time: ${widget.extTime}",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(height: 8,),

            // Row(
            //   children: [
            //     const Text(
            //       "Returned Date: destination",
            //       style: TextStyle(
            //         fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
            //     ),
            //
            //     const SizedBox(width: 5,),
            //     Container(color: Colors.red, height: 12, width: 2,),
            //     const SizedBox(width: 5,),
            //
            //     const Text(
            //       "Time: destination",
            //       style: TextStyle(
            //         fontSize: 14, color: Colors.black,),maxLines: 1, overflow: TextOverflow.ellipsis,
            //     ),
            //
            //   ],
            // ),

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
