abstract class EmailLoginState {}

class EmailLoginInit extends EmailLoginState {}

class EmailLoginLoading extends EmailLoginState {}

class EmailLoginSuccess extends EmailLoginState {}

class EmailLoginError extends EmailLoginState {
  final String errormsg;
  EmailLoginError({required this.errormsg});
}
