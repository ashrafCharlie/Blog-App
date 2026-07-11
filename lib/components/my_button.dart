import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const MyButton({super.key,required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: const Color.fromARGB(255, 175, 173, 173),
          ),
          child: Center(child: Text(buttonText,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: const Color.fromARGB(255, 217, 214, 214)
          ),)),
        ),
      ),
    );
  }
}
