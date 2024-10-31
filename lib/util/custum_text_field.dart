import 'package:flutter/material.dart';

class fieldForm extends StatelessWidget {
  String label;
  TextEditingController controller;

  fieldForm({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          )),
    );
  }
}
