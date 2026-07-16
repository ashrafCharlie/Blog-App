import 'package:blog_app/models/display_data_model.dart';

abstract class FetchBlogState {}

class FetchBlogInitState extends FetchBlogState {}

class FetchblogLoadingState extends FetchBlogState {}

class FetchBlogSuccessState extends FetchBlogState {
  final List<DisplayDataModel> blogList;
  FetchBlogSuccessState({required this.blogList});
}

class FetchBlogErrorState extends FetchBlogState {
  final String errorMsg;
  FetchBlogErrorState({required this.errorMsg});
}
