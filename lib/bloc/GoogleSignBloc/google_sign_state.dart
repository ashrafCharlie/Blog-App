abstract class GoogleSignState {}

class GoogleSigninit extends GoogleSignState {}

class GoogleSignLoading extends GoogleSignState {}

class GoogleSignSuccess extends GoogleSignState {}

class GoogleSignError extends GoogleSignState {
  final String googleSignErro;
  GoogleSignError({required this.googleSignErro});
}
