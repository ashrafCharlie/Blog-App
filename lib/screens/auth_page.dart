import 'package:blog_app/screens/login_screen.dart';
import 'package:blog_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
 const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginpage = true;
  void togglePage() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return LoginScreen(togglepages: togglePage,);
    } else {
      return SignupScreen(togglepages: togglePage,);
    }
  }
}
