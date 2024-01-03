import 'package:flutter/material.dart';
import 'package:hostel_management/Admin/admin_home/admin_visitor/visitor_details.dart';


class VisitorCard extends StatelessWidget {
  const VisitorCard({super.key, this.onTap, this.color, required this.arrivalDate, required this.arrivalTime, required this.purpose, required this.exitDate, required this.exitTime, required this.requestDate, required this.requestTime, this.returnedDate, this.returnedTime, required this.visitorName, required this.visitorPhoneNo, required this.relationship, required this.docId, required this.status, required this.name, required this.regNo, required this.roomNo, required this.phoneNo});

  final Function () ? onTap;
  final Color ? color;

  final String visitorName;
  final String visitorPhoneNo;
  final String relationship;
  final String arrivalDate;
  final String arrivalTime;
  final String purpose;
  final String exitDate;
  final String exitTime;
  final String requestDate;
  final String requestTime;
  final String ? returnedDate;
  final String ? returnedTime;
  final String docId;
  final String status;

  final String name;
  final String regNo;
  final String roomNo;
  final String phoneNo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => VisitorDetailsPage(
          visitorName: visitorName,
          purpose: purpose,
          visitorPhoneNo: visitorPhoneNo,
          arrivalDate: arrivalDate,
          arrivalTime: arrivalTime,
          extDate: exitDate,
          extTime: exitTime,
          requestDate: requestDate,
          requestTime: requestTime,
          relationship: relationship,
          status: status,
          docId: docId,
          name: name,
          phoneNo: phoneNo,
          roomNo: roomNo,
          regNo: regNo,
        )));
      },
      child: SizedBox(
        height: 250,
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
                    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),

                Text(
                  "Reg. no: $regNo",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),

                Text(
                  "Room. no: $roomNo",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),


                Text(
                  "Visitor's name: $visitorName",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),

                Text(
                  "Visitor's phone no: $visitorPhoneNo",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),

                Text(
                  "Relationship: $relationship",
                  style: const TextStyle(
                    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500,),maxLines: 2, overflow: TextOverflow.ellipsis,
                ),


                const SizedBox(height: 4,),

                Row(
                  children: [
                    Text(
                      "Visiting date: $arrivalDate",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.white),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(width: 5,),
                    Container(color: Colors.red, height: 12, width: 2,),
                    const SizedBox(width: 5,),

                    Text(
                      "Time: $arrivalTime",
                      style: const TextStyle(
                        fontSize: 14, color: Colors.white,),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                const SizedBox(height: 4,),
                Row(
                  children: [
                    Text(
                      "Exit Date: $exitDate",
                      style: const TextStyle(
                        fontSize: 14, color: Colors.white,),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(width: 5,),
                    Container(color: Colors.red, height: 12, width: 2,),
                    const SizedBox(width: 5,),

                    Text(
                      "Time: $exitTime",
                      style: const TextStyle(
                        fontSize: 14, color: Colors.white,),maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                const SizedBox(height: 4,),

                 Text(
                  "Visiting Purpose:  \n$purpose",
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
