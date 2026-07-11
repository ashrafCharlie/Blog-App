import 'package:flutter/material.dart';

class ContinueWithGoogle extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const ContinueWithGoogle({super.key,required this.onTap,required this.text,});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
              onTap: onTap,
            child: Text("Continue With Google",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35.0
            ),),
          );
  }
}