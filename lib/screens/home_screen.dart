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
import 'package:blog_app/repository/firebase_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseRepo _firebaseRepo = FirebaseRepo();
  final textController = TextEditingController();
  String username = '';

  @override
  void dispose() {
    // TODO: implement dispose
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.multiline,
                      controller: textController,
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: "Write a blog.....",
                        hintStyle: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    textController.clear();
                  },
                  child: Text("Cancel"),
                ),

                BlocBuilder<SendBlogBloc, SendBlogState>(
                  builder: (context, state) {
                    if (state is SendBlogLoading) {
                      return CircularProgressIndicator(
                        color: Colors.deepPurple,
                        strokeWidth: 2,
                      );
                    }
                    return TextButton(
                      onPressed: () {
                        if (textController.text.trim().isEmpty) {
                          return mySnacbar(context, "Write something.....");
                        }
                        context.read<SendBlogBloc>().add(
                          SendBlogEventClikced(
                            blogText: textController.text.trim(),
                            sender: username,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: Text("Post"),
                    );
                  },
                ),
              ],
            ),
          );
          //blog writeing Box
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 50,
          width: 80,
          child: Center(
            child: Text(
              "Write blog",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        toolbarHeight: 100,
        centerTitle: true,
        title: BlocBuilder<AppAuthBloc, AppAuthState>(
          builder: (context, state) {
            if (state is AppAuthSuccess) {
              username = state.userName;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hello ${state.userName.toString()}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "email : ${state.userEmail.toString()}",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 8.0),
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
          BlocListener<FetchBlogBloc, FetchBlogState>(
            listener: (context, state) {
              if (state is FetchBlogErrorState) {
                mySnacbar(context, state.errorMsg.toString());
              }
            },
            child: Container(),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                BlocBuilder<FetchBlogBloc, FetchBlogState>(
                  builder: (context, state) {
                    if (state is FetchblogLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is FetchBlogSuccessState) {
                      final blogList = state.blogList;
                      if (blogList.isEmpty) {
                        return Center(child: Text("No blogs found..."));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: blogList.length,
                        itemBuilder: (context, index) {
                          final blogdata = blogList[index];
                          final isMe =
                              blogdata.senderId ==
                              _firebaseRepo.currentUser!.uid;
                          String formattedTime = blogdata.createdAt != null
                              ? DateFormat(
                                  'dd MMM, yyyy • hh:mm a',
                                ).format(blogdata.createdAt!)
                              : "just now";
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Author : ${isMe ? 'You' : blogdata.sender}  ",
                                        style: TextStyle(fontSize: 12),
                                      ),

                                      Expanded(
                                        child: Text(
                                          "Time: $formattedTime",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      43,
                                      43,
                                      43,
                                    ),
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 8.0),
                                      Text(
                                        blogdata.blogText,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is FetchBlogErrorState) {
                      return Text("Error: ${state.errorMsg}");
                    }
                    return Text("something wrong");
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
