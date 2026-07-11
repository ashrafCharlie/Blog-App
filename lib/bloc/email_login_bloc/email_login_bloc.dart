import 'package:blog_app/bloc/email_login_bloc/email_login_event.dart';
import 'package:blog_app/bloc/email_login_bloc/email_login_state.dart';
import 'package:blog_app/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginState> {
  final FirebaseRepo firebaseRepo;
  EmailLoginBloc({required this.firebaseRepo}) : super(EmailLoginInit()) {
    on<EmailLoginClickEvent>((event, emit) async {
      emit(EmailLoginLoading());
      try {
        await firebaseRepo.loginByEmailPassword(
          email: event.email,
          password: event.password,
        );
          emit(EmailLoginSuccess());
      } catch (e) {
        emit(EmailLoginError(errormsg: "Login Failed, error: $e"));
      }
    });
  }
}
