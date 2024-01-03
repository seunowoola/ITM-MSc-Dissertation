
import 'package:flutter/material.dart';
import 'package:hostel_management/constants/colors.dart';


class TextFieldWidget extends StatelessWidget {
  final Function onTap;
  final FocusNode focusNode;
  final void Function(String) onChangedFunc;
  final Color enabledColor;
  final Color labelColor;
  final Widget ? sufIcon;
  final TextInputType ? inputType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController controller;
  final String labelText;
  final int ? maxLine;

  const TextFieldWidget({Key? key, required this.onTap, required this.focusNode,
    required this.onChangedFunc, required this.enabledColor, required this.labelColor,
   this.sufIcon, this.inputType, required this.validator,
    required this.obscureText, required this.controller, required this.labelText, this.maxLine,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onTap: (){
        onTap();
      },

      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: inputType,
      onChanged: onChangedFunc,
      focusNode: focusNode,
      maxLines: maxLine,
      decoration:  InputDecoration(
        suffixIcon: sufIcon,
        labelText: labelText,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        fillColor: Colors.white,
        labelStyle: TextStyle(color: labelColor),

        enabledBorder:  OutlineInputBorder(
          borderSide: BorderSide(color:enabledColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),


        focusedBorder:   OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),

        focusedErrorBorder:  OutlineInputBorder(
          borderSide: BorderSide(color: mainColor.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),

        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),

    );
  }
}
