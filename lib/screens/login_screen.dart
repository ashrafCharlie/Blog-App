import 'package:blog_app/bloc/email_login_bloc/email_login_bloc.dart';
import 'package:blog_app/bloc/email_login_bloc/email_login_event.dart';
import 'package:blog_app/components/continue_with_google.dart';
import 'package:blog_app/components/my_button.dart';
import 'package:blog_app/components/my_snacbar.dart';
import 'package:blog_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? togglepages;
  const LoginScreen({super.key, this.togglepages});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  //login Method
  void Login() {
    final loginBloc = context.read<EmailLoginBloc>();
    final String email = emailController.text.trim();
    final String password = pwController.text.trim();

    if (password.isEmpty && email.isNotEmpty) {
      loginBloc.add(EmailLoginClickEvent(email: email, password: password));
    } else {
      mySnacbar(context, "Fileds cannot be empty!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Login Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_open, size: 150),
            Text(
              "L o g i n  H e r e ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            const SizedBox(height: 20.0),

            MyTextfield(controller: emailController, hintText: "Email"),
            const SizedBox(height: 20.0),

            MyTextfield(
              controller: pwController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: AlignmentGeometry.centerEnd,
              child: Padding(
                padding: EdgeInsetsGeometry.only(right: 25.0),
                child: GestureDetector(
                  onTap: () {
                    print("forgot passwrod printed");
                  },
                  child: Text("Forget password?"),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            MyButton(
              buttonText: "L o g i n",
              onTap: () {
                Login();
              },
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have any Account? "),
                GestureDetector(
                  onTap: widget.togglepages,
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 25.0),
              child: Divider(color: Colors.grey),
            ),
            ContinueWithGoogle(
              onTap: () {
                print("continue with google login,");
              },
              text: "Continue with Google",
            ),
          ],
        ),
      ),
    );
  }
}
