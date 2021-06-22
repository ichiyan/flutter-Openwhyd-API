import 'package:flutter/material.dart';

import '../app_colors.dart';
import 'custom_text_form_field.dart';

class PasswordField extends StatelessWidget {
  final String labelText, hintText;
  final TextEditingController? textEditingController;
  final bool obscureText;
  final VoidCallback? onTap;
  final String? Function(String?)? validation;

  PasswordField({
    required this.labelText,
    required this.hintText,
    this.textEditingController,
    required this.obscureText,
    this.onTap,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    // return TextFormField(
    //   controller: textEditingController,
    //   obscureText: obscureText,
    //   validator: validation,
    //   decoration: InputDecoration(
    //     prefixIcon: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 15.0),
    //       child: Icon(Icons.lock),
    //     ),
    //     suffixIcon: GestureDetector(
    //       onTap: onTap,
    //       child: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
    //     ),
    //     labelText: labelText,
    //     hintText: hintText,
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(30.0)),
    //     ),
    //   ),
    // );
    return TextFormField(
      validator: validation,
      controller: textEditingController,
      obscureText: obscureText,
      style: TextStyle(color: AppColors.kTextColor),
      decoration: InputDecoration(
        prefixIcon: Container(
          //padding: EdgeInsets.symmetric(horizontal: 15.0),
          width: 56,
          height: 56,
          alignment: Alignment.center,
          child: Icon(Icons.lock, color: Colors.tealAccent[400]),
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.tealAccent[400]),
        ),
        labelText: labelText,
        hintText: hintText,
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
