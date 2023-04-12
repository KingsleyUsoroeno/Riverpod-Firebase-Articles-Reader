import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/data/exceptions.dart';
import 'package:sport_house/data/service/authentication_service.dart';
import 'package:sport_house/ui/screens/sign-up/provider/sign_up_screen_state.dart';

final signUpScreenProvider =
    StateNotifierProvider.autoDispose<SignUpScreenStateNotifier, SignUpScreenState>(
        (ref) => SignUpScreenStateNotifier(ref.read(authenticationServiceProvider)));

class SignUpScreenStateNotifier extends StateNotifier<SignUpScreenState> {
  final AuthenticationService authService;

  SignUpScreenStateNotifier(this.authService) : super(SignUpScreenState());

  void refresh() => state = SignUpScreenState(authState: AuthState.idle);

  Future<void> signUpUser(String email, String password, String username) async {
    try {
      state = state.copyWith(authState: AuthState.isAuthenticating);
      await authService.authenticateUser(
        emailAddress: email,
        password: password,
        authType: AuthenticationType.signUp,
        username: username,
      );
      state = state.copyWith(authState: AuthState.isAuthenticated);
    } on WeakPasswordException catch (e) {
      state = state.copyWith(authState: AuthState.authenticationFailed, errorMessage: e.message);
    } on EmailAlreadyInUseException catch (e) {
      state = state.copyWith(authState: AuthState.authenticationFailed, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(
        authState: AuthState.authenticationFailed,
        errorMessage: "Something went wrong, please try again",
      );
    }
  }
}
