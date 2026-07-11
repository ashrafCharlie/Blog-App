import 'package:blog_app/bloc/App_auth_bloc/app_auth_event.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final User? user;
  AppAuthBloc({required this.user}) : super(AppAuthInitState()) {
    on<AppAuthencationEvent>((event, emit) {
      emit(AppAuthInitState());
      try {
        if (user != null) {
          emit(AppAuthSuccess());
        } else {
          emit(AppAuthUnSuccess());
        }
      } catch (e) {
        emit(AppAuthUnSuccess());
      }
    });
  }
}
