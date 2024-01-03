import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/widgets/option_button.dart';


class VisitorDetailsPage extends StatefulWidget {
  const VisitorDetailsPage({super.key, required this.visitorName, required this.visitorPhoneNo, required this.requestDate, required this.requestTime, required this.purpose, required this.relationship, required this.extDate, required this.extTime, required this.arrivalDate, required this.arrivalTime, required this.docId, required this.status, required this.name, required this.regNo, required this.roomNo, required this.phoneNo});

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

  final String name;
  final String regNo;
  final String roomNo;
  final String phoneNo;

  final String docId;
  final String status;

  @override
  State<VisitorDetailsPage> createState() => _VisitorDetailsPageState();
}

class _VisitorDetailsPageState extends State<VisitorDetailsPage> {
  final DatabaseServices _databaseServices = DatabaseServices();

  updateStatus({required String status})async{
    _databaseServices.updateStatus(collectionName: "visitors",docId: widget.docId, docInfo: <String, dynamic>{
      "status": status
    });
    Navigator.pop(context);
  }

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
            Text("Name: ${widget.name}"),

            const SizedBox(height: 8,),

            Text("Reg. no: ${widget.regNo}"),

            const SizedBox(height: 8,),

            Text("Room. no: ${widget.roomNo}"),

            const SizedBox(height: 8,),

            Text("Phone. no: ${widget.phoneNo}"),

            const SizedBox(height: 8,),

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


            const SizedBox(height: 20,),

            widget.status == "new" ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(title: "Approve", width: 117, onTap: ()async{
                  await updateStatus(status: "active");
                  Fluttertoast.showToast(msg: "Updated Successfully");
                },),
                const SizedBox(width: 5,),
                Flexible(child: ButtonWidget(title: "Reject", width: 150, onTap: ()async{
                  await updateStatus(status: "rejected");
                  Fluttertoast.showToast(msg: "Updated Successfully");
                },)),
                const SizedBox(width: 5,),

                Flexible(child: ButtonWidget(title: "Delete", width: 150, onTap: ()async{
                  _databaseServices.deleteBooking(docId: widget.docId);
                  Fluttertoast.showToast(msg: "Deleted Successfully");
                  Navigator.pop(context);
                },)),
              ],
            ) : widget.status == "active" ?
            Center(
              child: ButtonWidget(title: "completed", width: 200, onTap: ()async{
                await updateStatus(status: "completed");
                Fluttertoast.showToast(msg: "Updated Successfully");
              },),
            ) : widget.status == "rejected" ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(title: "Approve", width: 150, onTap: ()async{
                  await updateStatus(status: "active");
                  Fluttertoast.showToast(msg: "Updated Successfully");
                },),

                const SizedBox(width: 5,),

                Flexible(child: ButtonWidget(title: "Delete", width: 150, onTap: ()async{
                  _databaseServices.deleteBooking(docId: widget.docId);
                  Fluttertoast.showToast(msg: "Deleted Successfully");
                  Navigator.pop(context);
                },)),
              ],
            )

                : const SizedBox(),

            const SizedBox(height: 30,)

          ],
        ),
      ),
    );
  }
}
