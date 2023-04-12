import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/data/exceptions.dart';
import 'package:sport_house/data/service/authentication_service.dart';
import 'package:sport_house/ui/screens/login/provider/login_screen_state.dart';
import 'package:sport_house/ui/screens/sign-up/provider/sign_up_screen_state.dart';

final loginScreenProvider =
    StateNotifierProvider.autoDispose<LoginScreenStateNotifier, LoginScreenState>(
        (ref) => LoginScreenStateNotifier(ref.read(authenticationServiceProvider)));

class LoginScreenStateNotifier extends StateNotifier<LoginScreenState> {
  final AuthenticationService authService;

  LoginScreenStateNotifier(this.authService) : super(LoginScreenState());

  void refresh() => state = LoginScreenState(authState: AuthState.idle);

  Future<void> loginUser(String email, String password) async {
    try {
      state = state.copyWith(authState: AuthState.isAuthenticating);
      await authService.authenticateUser(
          emailAddress: email, password: password, authType: AuthenticationType.login);
      state = state.copyWith(authState: AuthState.isAuthenticated);
    } on UserNotFoundException catch (e) {
      state = state.copyWith(authState: AuthState.authenticationFailed, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        authState: AuthState.authenticationFailed,
        errorMessage: "Something went wrong, please try again",
      );
    }
  }
}
