import 'package:blog_app/bloc/fetch_blog_bloc/fetch_blog_event.dart';
import 'package:blog_app/bloc/fetch_blog_bloc/fetch_blog_state.dart';
import 'package:blog_app/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchBlogBloc extends Bloc<FetchBlogEvent, FetchBlogState> {
  final FirebaseRepo _firebaseRepo;
  FetchBlogBloc(this._firebaseRepo) : super(FetchBlogInitState()) {
    on<FetchBlogEventClicked>((event, emit) async {
      emit(FetchblogLoadingState());
      try {
      await emit.forEach(
           _firebaseRepo.fetchBlogData(), 
        onData:(blogList)=> FetchBlogSuccessState(blogList: blogList),
        onError: (error, stackTrace) => FetchBlogErrorState(errorMsg: error.toString()),
        );
      } catch (e) {
        emit(FetchBlogErrorState(errorMsg: e.toString()));
      }
    });
  }
}
