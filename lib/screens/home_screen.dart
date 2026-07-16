import 'package:blog_app/bloc/App_auth_bloc/app_auth_bloc.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_event.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_state.dart';
import 'package:blog_app/bloc/fetch_blog_bloc/fetch_blog_bloc.dart';
import 'package:blog_app/bloc/fetch_blog_bloc/fetch_blog_state.dart';
import 'package:blog_app/bloc/send_blog_bloc/send_blog_bloc.dart';
import 'package:blog_app/bloc/send_blog_bloc/send_blog_event.dart';
import 'package:blog_app/bloc/send_blog_bloc/send_blog_state.dart';
import 'package:blog_app/components/my_alert_dailog.dart';
import 'package:blog_app/components/my_snacbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        toolbarHeight: 80.0,
        centerTitle: true,
        title: BlocBuilder<AppAuthBloc, AppAuthState>(
          builder: (context, state) {
            if (state is AppAuthSuccess) {
              username = state.userName;
              return Column(
                children: [
                  Text("Hello ${state.userName.toString()}"),
                  Text("email : ${state.userEmail.toString()}"),
                ],
              );
            } else {
              return Text("user");
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppAuthBloc>().add(AppLogoutEvent());
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              myAleartDailog(
                context: context,
                onPressed: () {
                  context.read<AppAuthBloc>().add(AppUserDeleteEvent());
                  Navigator.pop(context);
                },
                content: "Delete this account",
                okButtonText: "Confirm",
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AppAuthBloc, AppAuthState>(
            listener: (context, state) {
              if (state is AppLogoutError) {
                mySnacbar(context, state.logoutErrorMsg.toString());
              }
              if (state is AppUserDeleteError) {
                mySnacbar(context, state.userDeleteError.toString());
              }
            },
          ),
          BlocListener<SendBlogBloc, SendBlogState>(
            listener: (context, state) {
              if (state is SendBlogError) {
                mySnacbar(context, state.errorMsg.toString());
              }
              if (state is SendBlogSuccess) {
                mySnacbar(context, "Blog post Success");
                textController.clear();
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: textController,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Write a blog here!",
                      hintStyle: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 25.0,
                      ),
                      filled: true,
                      fillColor: Colors.grey[600],
                      border: OutlineInputBorder(),
                      suffix: BlocBuilder<SendBlogBloc, SendBlogState>(
                        builder: (context, state) {
                          if (state is SendBlogLoading) {
                            return CircularProgressIndicator(
                              color: Colors.deepPurple,
                              strokeWidth: 2,
                            );
                          }
                          return IconButton(
                            onPressed: () {
                              context.read<SendBlogBloc>().add(
                                SendBlogEventClikced(
                                  blogText: textController.text.trim(),
                                  sender: username,
                                ),
                              );
                            },
                            icon: Icon(Icons.send),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                 SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor"),
              SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor"),
                SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor"),
                SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor"),
                SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor"),
                SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor"),
                SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor"),
                SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor"),
                SizedBox(height: 15,),
              Text("Text(String data, {Key? key, TextStyle? style, StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
