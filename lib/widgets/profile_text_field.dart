import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';



class ProfileTextField extends StatelessWidget {
  const ProfileTextField({Key? key, this.suffixIcon, required this.hintText, this.obscureText, required this.labelText, this.keyboardType, this.validator,  this.controller}) : super(key: key);


  final Widget ? suffixIcon;
  final String  hintText;
  final bool ? obscureText;
  final String labelText;
  final TextInputType ? keyboardType;
  final String? Function (String?) ? validator;
  final TextEditingController ? controller;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        // height: 45,
        child: TextFormField(
          obscureText: obscureText ?? false,
          // errorStyle: const TextStyle(fontSize: 0.01),
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          controller: controller,
          decoration: InputDecoration(
              isDense: true,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 13, horizontal: 10.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:  BorderSide(color: mainColor.withOpacity(0.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),),


              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: mainColor.withOpacity(0.2)),),




              suffixIcon: suffixIcon,

              hintText: hintText,
              label: Text(labelText),

              hintStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey),

          ),
        ),
      ),
    );
  }
}