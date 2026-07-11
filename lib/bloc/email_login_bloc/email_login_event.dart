abstract class EmailLoginEvent {}

class EmailLoginClickEvent extends EmailLoginEvent {
  final String email;
  final String password;
  EmailLoginClickEvent({required this.email, required this.password});
}
