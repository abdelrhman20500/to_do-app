import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  MyTextFiled({super.key, this.hintText, required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}