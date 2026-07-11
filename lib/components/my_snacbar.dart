import 'package:flutter/material.dart';

void mySnacbar(BuildContext context, String textmsg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(textmsg)));
}
