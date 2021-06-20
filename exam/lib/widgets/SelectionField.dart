import 'package:flutter/material.dart';

class SelectionField extends StatefulWidget {
  final List<String> values;
  final String? Function(String?)? validation;
  final void Function(String?) getSelected;
  final String? selected;

  SelectionField({
    required this.values,
    this.validation,
    required this.getSelected,
    this.selected,
  });

  @override
  _SelectionFieldState createState() => _SelectionFieldState();
}

class _SelectionFieldState extends State<SelectionField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: "Civilian",
      validator: widget.validation,
      onChanged: widget.getSelected,
      items: widget.values.map((String value) {
        return new DropdownMenuItem(value: value, child: new Text(value));
      }).toList(),
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Icon(Icons.person_add),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
