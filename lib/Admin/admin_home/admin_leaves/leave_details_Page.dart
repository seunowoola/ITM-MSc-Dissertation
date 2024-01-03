import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostel_management/backend/database_service.dart';
import 'package:hostel_management/constants/colors.dart';
import 'package:hostel_management/widgets/option_button.dart';


class LeaveDetailsPage extends StatefulWidget {
  const LeaveDetailsPage({super.key, required this.leaveDate, required this.leaveTime, required this.purpose, required this.returnDate, required this.returnTime, required this.destination, required this.requestDate, required this.requestTime, this.returnedDate, this.returnedTime, required this.docId, required this.status, required this.name, required this.regNo, required this.roomNo, required this.phoneNo});
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
  final String docId;
  final String status;

  final String name;
  final String regNo;
  final String roomNo;
  final String phoneNo;

  @override
  State<LeaveDetailsPage> createState() => _LeaveDetailsPageState();
}

class _LeaveDetailsPageState extends State<LeaveDetailsPage> {

  final DatabaseServices _databaseServices = DatabaseServices();

  updateStatus({required String status})async{
    _databaseServices.updateStatus(collectionName: "leaves",docId: widget.docId, docInfo: <String, dynamic>{
      "status": status
    });
    Navigator.pop(context);
  }

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

            Text("Name: ${widget.name}"),

            const SizedBox(height: 8,),

            Text("Reg. no: ${widget.regNo}"),

            const SizedBox(height: 8,),

            Text("Room no: ${widget.roomNo}"),

            const SizedBox(height: 8,),

            Text("Phone no: ${widget.phoneNo}"),

            const SizedBox(height: 8,),

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
