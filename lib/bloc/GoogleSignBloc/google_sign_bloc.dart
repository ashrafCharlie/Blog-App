import 'package:blog_app/bloc/GoogleSignBloc/google_sign_event.dart';
import 'package:blog_app/bloc/GoogleSignBloc/google_sign_state.dart';
import 'package:blog_app/models/user_data_model.dart';
import 'package:blog_app/repository/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleSignBloc extends Bloc<GoogleSignEvent, GoogleSignState> {
  final FirebaseRepo firebaseRepo;
  GoogleSignBloc({required this.firebaseRepo}) : super(GoogleSigninit()) {
    on<GoogleSignClickedEvent>((event, emit) async {
      emit(GoogleSignLoading());
      try {
         await firebaseRepo
            .signInWithGoogle();
               
        emit(GoogleSignSuccess());
      } catch (e) {
        emit(GoogleSignError(googleSignErro: "$e"));
      }
    });
  }
}
