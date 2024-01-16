import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  final  controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,

    required this.controller,
    required this.hintText,
    required this.obscureText,




  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(


          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade900),
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          ),
          fillColor: Colors.white38,
          filled: true,
          hintText: hintText,
        ),
      ),
    );

  }
}
