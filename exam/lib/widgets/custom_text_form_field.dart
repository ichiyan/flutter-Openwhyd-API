import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText, hintText;
  final IconData? iconData;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String? Function(String?)? validation;

  CustomTextFormField(
      {required this.labelText,
      required this.hintText,
      this.iconData,
      required this.textEditingController,
      required this.textInputType,
      this.validation});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      controller: textEditingController,
      keyboardType: textInputType,
      //autofocus: true,
      style: TextStyle(color: AppColors.kTextColor),
      decoration: InputDecoration(
        prefixIcon: Container(
          //padding: EdgeInsets.symmetric(horizontal: 15.0),
          width: 56,
          height: 56,
          alignment: Alignment.center,
          child: Icon(
            iconData,
            color: Colors.tealAccent[400],
          ),
        ),
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[350]),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(30.0)),
        // ),
        border: kInputBorder,
        focusedBorder: kInputBorder,
        enabledBorder: kInputBorder,
        errorMaxLines: 2,
      ),
    );
  }
}

InputBorder kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: BorderSide(
    width: 2,
    color: Color(0xFFECECEC),
  ),
);
