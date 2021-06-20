import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormField extends StatefulWidget {
  final String labelText, hintText;
  final TextInputType textInputType;
  final String? Function(String?) validation;

  DateFormField({
    required this.hintText,
    required this.labelText,
    required this.textInputType,
    required this.validation,
  });

  @override
  _DateFormFieldState createState() => _DateFormFieldState();
}

class _DateFormFieldState extends State<DateFormField> {
  TextEditingController textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: TextInputType.datetime,
      validator: widget.validation,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2022),
        ).then(
          (datePick) => {
            textEditingController.text =
                DateFormat('yyyy-MM-dd').format(datePick!),
          },
        );
      },
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Icon(Icons.calendar_today),
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
