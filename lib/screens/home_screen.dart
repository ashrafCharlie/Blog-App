import 'package:blog_app/bloc/App_auth_bloc/app_auth_bloc.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_event.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_state.dart';
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
      body: BlocListener<AppAuthBloc, AppAuthState>(
        listener: (context, state) {
          if (state is AppLogoutError) {
            return mySnacbar(context, state.logoutErrorMsg.toString());
          }
          if (state is AppUserDeleteError) {
            return mySnacbar(context, state.userDeleteError.toString());
          }
        },

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.multiline,

                controller: textController,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
