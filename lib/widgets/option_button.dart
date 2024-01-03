import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';



class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.title, required this.width,
    this.onTap, this.titleColor, this.buttonColor}) : super(key: key);

  final String title;
  final Color ? titleColor;
  final double width;
  final Function () ? onTap;
  final Color ? buttonColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),)),
        elevation: MaterialStateProperty.all(0.0),
          minimumSize: MaterialStateProperty.all<Size>(Size(width, 40)),
          maximumSize: MaterialStateProperty.all<Size>(Size(width, 40)),
          backgroundColor: MaterialStateProperty.all(buttonColor ?? buttonColors),
      ),

      onPressed: onTap,

      child: Text(title, style: TextStyle(color: titleColor ?? Colors.white, fontWeight: FontWeight.w600, fontSize: 18),),

    );
  }
}
