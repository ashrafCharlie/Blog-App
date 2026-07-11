abstract class EmailSignupState {}


class EmailSignUpInit extends EmailSignupState {}


class EmailSignUpLoading extends EmailSignupState {}


class EmailSignUpSuccess extends EmailSignupState {}


class EmailSignUpError extends EmailSignupState {
  final String errorMsg;
  EmailSignUpError({required this.errorMsg});
}
