import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
 

 const MyTextfield({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
   
        style: TextStyle(color: Colors.black),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: const Color.fromARGB(255, 107, 106, 106)),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.white),
          ),

          filled: true,
          fillColor: Colors.grey,
        ),
      ),
    );
  }
}
