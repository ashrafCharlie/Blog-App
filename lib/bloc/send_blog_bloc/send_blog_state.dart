abstract class SendBlogState {}
class SendBlogInitState extends SendBlogState{}
class SendBlogLoading extends SendBlogState {}

class SendBlogSuccess extends SendBlogState {}

class SendBlogError extends SendBlogState {
  final String errorMsg;
  SendBlogError(this.errorMsg);
  
}
