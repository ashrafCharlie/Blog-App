import 'package:blog_app/bloc/App_auth_bloc/app_auth_bloc.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_event.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_state.dart';
import 'package:blog_app/components/my_alert_dailog.dart';
import 'package:blog_app/components/my_snacbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Screen"),
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
        child: SingleChildScrollView(),
      ),
    );
  }
}
