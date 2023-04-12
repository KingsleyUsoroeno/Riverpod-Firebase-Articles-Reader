enum AuthState {
  idle,
  isAuthenticating,
  isAuthenticated,
  authenticationFailed,
  isNotAuthenticated
}

class SignUpScreenState {
  final String? errorMessage;
  final AuthState authState;

  SignUpScreenState({this.errorMessage, this.authState = AuthState.idle});

  bool get isUserAuthenticated => authState == AuthState.isAuthenticated;

  bool get isAuthenticating => authState == AuthState.isAuthenticating;

  SignUpScreenState copyWith({AuthState? authState, String? errorMessage}) {
    return SignUpScreenState(
        authState: authState ?? this.authState, errorMessage: errorMessage ?? this.errorMessage);
  }
}
