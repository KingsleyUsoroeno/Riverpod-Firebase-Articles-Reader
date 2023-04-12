import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sport_house/data/exceptions.dart';

enum AuthenticationType { signUp, login }

final authenticationServiceProvider = Provider((ref) {
  return AuthenticationService(FirebaseAuth.instance);
});

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Future<UserCredential?> authenticateUser({
    required String emailAddress,
    required String password,
    required AuthenticationType authType,
    String? username,
  }) async {
    try {
      late UserCredential userCredential;
      if (authType == AuthenticationType.signUp) {
        userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: emailAddress, password: password);
        final user = userCredential.user;
        if (username != null) user?.updateDisplayName(username);
      } else if (authType == AuthenticationType.login) {
        userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(email: emailAddress, password: password);
      } else {
        throw Exception("Invalid authentication type");
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw WeakPasswordException("The password provided is too weak.");

        case 'email-already-in-use':
          throw EmailAlreadyInUseException("An account already exists for that email.");

        case 'user-not-found':
        case 'wrong-password':
          throw UserNotFoundException("No user found with that email or password");
      }
    } catch (exception) {
      rethrow;
    }
    return null;
  }

  void checkCurrentAuthState(Function(User? user) onUserStateChange) {
    _firebaseAuth.authStateChanges().listen(onUserStateChange);
  }
}
