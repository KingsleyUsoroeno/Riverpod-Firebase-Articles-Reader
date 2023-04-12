import 'package:sport_house/ui/screens/sign-up/provider/sign_up_screen_state.dart';

class LoginScreenState {
  final String? errorMessage;
  final AuthState authState;

  LoginScreenState({this.errorMessage, this.authState = AuthState.isNotAuthenticated});

  bool get isUserAuthenticated => authState == AuthState.isAuthenticated;

  bool get isAuthenticating => authState == AuthState.isAuthenticating;

  LoginScreenState copyWith({AuthState? authState, String? errorMessage}) {
    return LoginScreenState(
      authState: authState ?? this.authState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
