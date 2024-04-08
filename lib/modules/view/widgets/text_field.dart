import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String? initialValue;
  String? hintText;
  bool? enabled;
  final IconData? icon;
  void Function(String)? onChanged;
  bool obscureText = false;
  String? Function(String?)? validator;

  MyTextField(
      {this.icon,
      this.onChanged,
      required this.obscureText,
      this.initialValue,
      this.enabled,
      this.hintText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black,
          ),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          fillColor: Colors.white,
          filled: true),
      enabled: enabled,
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: obscureText,
    );
  }
}
