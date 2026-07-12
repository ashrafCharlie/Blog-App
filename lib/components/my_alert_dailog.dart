import 'package:flutter/material.dart';

Future<dynamic> myAleartDailog({required BuildContext context, required void Function()? onPressed, required String content, required String okButtonText}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(onPressed:onPressed , child: Text(okButtonText)),
        ],
      );
    },
  );
}
