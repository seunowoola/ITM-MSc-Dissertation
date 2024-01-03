import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';


class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,child: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.white, valueColor: AlwaysStoppedAnimation<Color>(mainColor),
            strokeWidth: 6,
          ),
          SizedBox(height: 10,),

          Text("Please wait...", style: TextStyle(color: Colors.black, fontSize: 18),),
        ],
      ), ),
    );
  }
}
