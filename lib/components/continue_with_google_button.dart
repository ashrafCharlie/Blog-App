import 'package:flutter/material.dart';

class ContinueWithGoogle extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const ContinueWithGoogle({super.key,required this.onTap,required this.text,});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
              onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey[300],
              ),
           
              child: Text("Continue With Google",style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 35.0
              ),),
            ),
          );
  }
}