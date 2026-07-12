abstract class AppAuthState {}

class AppAuthInitState extends AppAuthState {}

class AppAuthSuccess extends AppAuthState {}

class AppAuthUnSuccess extends AppAuthState {}

class AppLogoutError extends AppAuthState {
  final String logoutErrorMsg;
  AppLogoutError({required this.logoutErrorMsg});
}
class AppUserDeleteError extends AppAuthState {
  final String userDeleteError;
  AppUserDeleteError({required this.userDeleteError});
}
