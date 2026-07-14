abstract class AppAuthState {}

class AppAuthInitState extends AppAuthState {}

class AppAuthSuccess extends AppAuthState {
  final String userName;
  final String userEmail;
  AppAuthSuccess(this.userName,this.userEmail);
}

class AppAuthUnSuccess extends AppAuthState {}

class AppLogoutError extends AppAuthState {
  final String logoutErrorMsg;
  AppLogoutError({required this.logoutErrorMsg});
}

class AppUserDeleteError extends AppAuthState {
  final String userDeleteError;
  AppUserDeleteError({required this.userDeleteError});
}
