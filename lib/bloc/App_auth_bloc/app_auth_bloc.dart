import 'package:blog_app/bloc/App_auth_bloc/app_auth_event.dart';
import 'package:blog_app/bloc/App_auth_bloc/app_auth_state.dart';
import 'package:blog_app/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final FirebaseRepo firebaseRepo = FirebaseRepo();
  AppAuthBloc() : super(AppAuthInitState()) {
    on<AppAuthencationEvent>((event, emit) {
      try {
        final user = firebaseRepo.currentUser;
        if (user != null) {
          emit(AppAuthSuccess());
        } else {
          emit(AppAuthUnSuccess());
        }
      } catch (e) {
        emit(AppAuthUnSuccess());
      }
    });

    on<AppLogoutEvent>((event, emit) {
      try {
        firebaseRepo.logout();
        emit(AppAuthUnSuccess());
      } catch (e) {
        emit(AppLogoutError(logoutErrorMsg: "$e"));
      }
    });

    on<AppUserDeleteEvent>((event, emit) {
      try {
        firebaseRepo.deleteAccount();
        emit(AppAuthUnSuccess());
      } catch (e) {
        emit(AppUserDeleteError(userDeleteError: "$e"));
      }
    });
  }
}
