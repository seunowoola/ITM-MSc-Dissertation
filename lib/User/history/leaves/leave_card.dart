import 'package:flutter/material.dart';
import 'package:hostel_management/User/history/leaves/leave_details_Page.dart';

class LeaveCard extends StatelessWidget {
  const LeaveCard({super.key, required this.destination,this.onTap, this.color, required this.leaveDate, required this.leaveTime, required this.purpose, required this.returnDate, required this.returnTime, required this.requestDate, required this.requestTime, this.returnedDate, this.returnedTime});

  final String destination;
  final Function () ? onTap;
  final Color ? color;
  final String leaveDate;
  final String leaveTime;
  final String purpose;
  final String returnDate;
  final String returnTime;
  final String requestDate;
  final String requestTime;
  final String ? returnedDate;
  final String ? returnedTime;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveDetailsPage(
          destination: destination,
          leaveDate: leaveDate,
          purpose: purpose,
          leaveTime: leaveTime,
          returnDate: returnDate,
          requestTime: requestTime,
          requestDate: requestDate,
          returnTime: returnTime,
          returnedDate: returnedDate,
          returnedTime: returnedTime,
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

                Text(
                  "Destination: $destination",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4,),

                Row(
                  children: [
                    Text(
                      "Leave Date: $leaveDate",
                      style: const TextStyle(
                        fontSize: 14, color: Colors.white),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(width: 5,),
                    Container(color: Colors.red, height: 12, width: 2,),
                    const SizedBox(width: 5,),

                    Text(
                      "Time: $leaveTime",
                      style: const TextStyle(
                        fontSize: 14, color: Colors.white,),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                const SizedBox(height: 4,),
                Row(
                  children: [
                    Text(
                      "Returning Date: $returnDate",
                      style: const TextStyle(
                        fontSize: 14, color: Colors.white,),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(width: 5,),
                    Container(color: Colors.red, height: 12, width: 2,),
                    const SizedBox(width: 5,),

                    Text(
                      "Time: $returnTime",
                      style: const TextStyle(
                        fontSize: 14, color: Colors.white,),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                const SizedBox(height: 4,),

                 Text(
                  "Purpose: $purpose",
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
