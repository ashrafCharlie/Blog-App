import 'package:blog_app/bloc/email_signup_bloc/email_signup_event.dart';
import 'package:blog_app/bloc/email_signup_bloc/email_signup_state.dart';
import 'package:blog_app/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailSignupBloc extends Bloc<EmailSignupEvent, EmailSignupState> {
  final FirebaseRepo firebaseRepo;
  EmailSignupBloc({required this.firebaseRepo}) : super(EmailSignUpInit()) {
    on<EmailsignUp>((event, emit) async {
      emit(EmailSignUpLoading());
      try {
        await firebaseRepo.signUpByEmailPassword(
          email: event.email,
          name: event.name,
          password: event.password,
        );
         emit(EmailSignUpSuccess());
      } catch (e) {
        emit(EmailSignUpError(errorMsg: "SignUp failed...Error: $e"));
      }
    });
  }
}
