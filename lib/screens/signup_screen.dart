import 'package:blog_app/bloc/App_auth_bloc/app_auth_bloc.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_event.dart';
import 'package:blog_app/bloc/GoogleSignBloc/google_sign_bloc.dart';
import 'package:blog_app/bloc/GoogleSignBloc/google_sign_event.dart';
import 'package:blog_app/bloc/GoogleSignBloc/google_sign_state.dart';
import 'package:blog_app/bloc/email_signup_bloc/email_signup_bloc.dart';
import 'package:blog_app/bloc/email_signup_bloc/email_signup_event.dart';
import 'package:blog_app/bloc/email_signup_bloc/email_signup_state.dart';
import 'package:blog_app/components/continue_with_google.dart';
import 'package:blog_app/components/my_alert_dailog.dart';
import 'package:blog_app/components/my_button.dart';
import 'package:blog_app/components/my_snacbar.dart';
import 'package:blog_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  final void Function()? togglepages;
  const SignupScreen({super.key, this.togglepages});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmailSignupBloc, EmailSignupState>(
            listener: (context, state) async {
              if (state is EmailSignUpError) {
                myAleartDailog(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  content: state.errorMsg.toString(),
                  okButtonText: "Retry",
                );
              }
              if (state is EmailSignUpSuccess) {
                mySnacbar(context, "Account create Successful");
                await Future.delayed(Duration(seconds: 1));
                context.read<AppAuthBloc>().add(AppAuthencationEvent());
              }
            },
          ),
          BlocListener<GoogleSignBloc, GoogleSignState>(
            listener: (context, state) async {
              if (state is GoogleSignError) {
                mySnacbar(context, state.googleSignErro.toString());
              }
              if (state is GoogleSignSuccess) {
                mySnacbar(context, "Welcome home");
                await Future.delayed(Duration(seconds: 1));
                context.read<AppAuthBloc>().add(AppAuthencationEvent());
              }
            },
          ),
        ],
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_open, size: 150),
                Text(
                  "S i g n  U p  H e r e",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                const SizedBox(height: 20.0),

                MyTextfield(controller: nameController, hintText: "Name"),
                const SizedBox(height: 15.0),

                MyTextfield(controller: emailController, hintText: "Email"),
                const SizedBox(height: 15.0),

                MyTextfield(
                  controller: pwController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 15.0),

                MyTextfield(
                  controller: confirmPwController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25.0),

                BlocBuilder<EmailSignupBloc, EmailSignupState>(
                  builder: (context, state) {
                    if (state is EmailSignUpLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return MyButton(
                      buttonText: "Sign Up",
                      onTap: () {
                        if (emailController.text.isNotEmpty &&
                            nameController.text.isNotEmpty &&
                            pwController.text.isNotEmpty &&
                            confirmPwController.text.isNotEmpty) {
                          if (confirmPwController.text == pwController.text) {
                            context.read<EmailSignupBloc>().add(
                              EmailsignUp(
                                email: emailController.text,
                                name: nameController.text,
                                password: pwController.text,
                              ),
                            );
                          } else {
                            mySnacbar(
                              context,
                              "Confirm Password don't match...",
                            );
                          }
                        } else {
                          mySnacbar(context, "Empty Filed.....");
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account? "),
                    GestureDetector(
                      onTap: widget.togglepages,
                      child: Text(
                        "Login",
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
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(color: Colors.grey),
                ),
                BlocBuilder<GoogleSignBloc, GoogleSignState>(
                  builder: (context, state) {
                    if (state is GoogleSignLoading) {
                      return Center(child: CircularProgressIndicator(color: Colors.purple,));
                    }
                    return ContinueWithGoogle(
                      onTap: () {
                        context.read<GoogleSignBloc>().add(
                          GoogleSignClickedEvent(),
                        );
                      },
                      text: "Continue With Google",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
