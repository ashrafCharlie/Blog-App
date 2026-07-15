import 'package:blog_app/bloc/send_blog_bloc/send_blog_event.dart';
import 'package:blog_app/bloc/send_blog_bloc/send_blog_state.dart';
import 'package:blog_app/core/display_data_model.dart';
import 'package:blog_app/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendBlogBloc extends Bloc<SendBlogEvent, SendBlogState> {
  final FirebaseRepo _firebaseRepo;
  SendBlogBloc(this._firebaseRepo) : super(SendBlogInitState()) {
    on<SendBlogEventClikced>((event, emit) async {
      emit(SendBlogLoading());
      try {
        await _firebaseRepo.sendBlog(
          blogsData: DisplayDataModel(
            blogText: event.blogText,
            sender: event.sender,
          ),
        );
        emit(SendBlogSuccess());
      } catch (e) {
        emit(SendBlogError(e.toString()));
      }
    });
  }
}
