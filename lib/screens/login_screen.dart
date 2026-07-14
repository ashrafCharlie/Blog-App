import 'package:blog_app/bloc/App_auth_bloc/app_auth_bloc.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_event.dart';
import 'package:blog_app/bloc/GoogleSignBloc/google_sign_bloc.dart';
import 'package:blog_app/bloc/GoogleSignBloc/google_sign_event.dart';
import 'package:blog_app/bloc/GoogleSignBloc/google_sign_state.dart';
import 'package:blog_app/bloc/email_login_bloc/email_login_bloc.dart';
import 'package:blog_app/bloc/email_login_bloc/email_login_event.dart';
import 'package:blog_app/bloc/email_login_bloc/email_login_state.dart';
import 'package:blog_app/components/continue_with_google_button.dart';
import 'package:blog_app/components/custom_divider.dart';
import 'package:blog_app/components/my_button.dart';
import 'package:blog_app/components/my_snacbar.dart';
import 'package:blog_app/components/my_textfield.dart';
import 'package:blog_app/repository/firebase_repo.dart';
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
  final TextEditingController resetEmailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    resetEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<EmailLoginBloc, EmailLoginState>(
            listener: (context, state) async {
              if (state is EmailLoginError) {
                mySnacbar(context, state.errormsg.toString());
              }
              if (state is EmailLoginSuccess) {
                mySnacbar(context, "Login Successful..");
                await Future.delayed(Duration(seconds: 1));
                context.read<AppAuthBloc>().add(AppAuthencationEvent());
                emailController.clear();
                pwController.clear();
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
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text("Reset Your Password"),

                            actions: [
                              TextField(
                                controller: resetEmailController,
                                decoration: InputDecoration(
                                  hintText: "Enter Your email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final firebaseRepo = FirebaseRepo();
                                      try {
                                        if (resetEmailController.text.isEmpty) {
                                          return mySnacbar(
                                            context,
                                            "Enter an email",
                                          );
                                        }
                                        final String resetmsg =
                                            await firebaseRepo.resetPassword(
                                              resetEmailController.text.trim(),
                                            );
                                        resetEmailController.clear();
                                        Navigator.pop(context);
                                        mySnacbar(context, resetmsg);
                                      } catch (e) {
                                        mySnacbar(context, e.toString());
                                      }
                                    },
                                    child: Text("Send Reset Link"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text("Forget password?"),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                BlocBuilder<EmailLoginBloc, EmailLoginState>(
                  builder: (context, state) {
                    if (state is EmailLoginLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return MyButton(
                      buttonText: "L o g i n",
                      onTap: () {
                        if (emailController.text.isNotEmpty &&
                            pwController.text.isNotEmpty) {
                          context.read<EmailLoginBloc>().add(
                            EmailLoginClickEvent(
                              email: emailController.text.trim(),
                              password: pwController.text.trim(),
                            ),
                          );
                        } else {
                          mySnacbar(context, "Empty fields...");
                        }
                      },
                    );
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
                CustomDivider("Or"),
                BlocBuilder<GoogleSignBloc, GoogleSignState>(
                  builder: (context, state) {
                    if (state is GoogleSignLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.purple),
                      );
                    }
                    return ContinueWithGoogle(
                      onTap: () {
                        context.read<GoogleSignBloc>().add(
                          GoogleSignClickedEvent(),
                        );
                      },
                      text: "Continue with Google",
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
