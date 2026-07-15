import 'package:blog_app/bloc/App_auth_bloc/app_auth_bloc.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_event.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_state.dart';
import 'package:blog_app/bloc/GoogleSignBloc/google_sign_bloc.dart';
import 'package:blog_app/bloc/email_login_bloc/email_login_bloc.dart';
import 'package:blog_app/bloc/email_signup_bloc/email_signup_bloc.dart';
import 'package:blog_app/bloc/send_blog_bloc/send_blog_bloc.dart';
import 'package:blog_app/screens/auth_page.dart';
import 'package:blog_app/firebase_options.dart';
import 'package:blog_app/repository/firebase_repo.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:blog_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AppAuthBloc()
                ..add(AppAuthencationEvent()),
        ),
        BlocProvider(create: (context) =>  SendBlogBloc(FirebaseRepo()),),
        BlocProvider(
          create: (context)=> GoogleSignBloc(firebaseRepo: FirebaseRepo()),
          )
        ,
        BlocProvider(
          create: (context) => EmailSignupBloc(firebaseRepo: FirebaseRepo()),
          child: SignupScreen(),
        ),
        BlocProvider(
          create: (context) => EmailLoginBloc(firebaseRepo: FirebaseRepo()),
          child: LoginScreen(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AppAuthBloc, AppAuthState>(
          builder: (context, state) {
            if (state is AppAuthInitState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AppAuthSuccess) {
              return HomeScreen();
            } else {
              return AuthPage();
            }
          },
        ),
      ),
    );
  }
}
