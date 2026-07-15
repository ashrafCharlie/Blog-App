abstract class SendBlogEvent {}

class SendBlogEventClikced extends SendBlogEvent {
  final String blogText;
  final String sender;
  SendBlogEventClikced({required this.blogText,required this.sender});
}
