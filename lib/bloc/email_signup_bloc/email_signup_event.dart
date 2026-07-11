abstract class EmailSignupEvent {}

class EmailsignUp extends EmailSignupEvent {
  final String name;
  final String email;
  final String password;
  EmailsignUp({
    required this.email,
    required this.name,
    required this.password,
  });
}
