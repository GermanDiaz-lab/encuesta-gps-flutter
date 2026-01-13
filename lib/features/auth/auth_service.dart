import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'local_user_repository.dart';

class AuthService {
  AuthService({LocalUserRepository? localUserRepository})
      : _localUserRepository = localUserRepository ?? LocalUserRepository();

  final LocalUserRepository _localUserRepository;

  Future<void> signIn({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      throw StateError('Es necesario completar todos los campos!!');
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw StateError(error.message ?? error.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty ||
        confirmPassword.trim().isEmpty) {
      throw StateError('Es necesario completar todos los campos!!');
    }

    if (password != confirmPassword) {
      throw StateError('Contraseña no coincide!!');
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw StateError(error.message ?? error.toString());
    }
  }

  bool get hasCurrentUser => FirebaseAuth.instance.currentUser != null;

  Future<void> signOut() async {
    await _localUserRepository.borrarUsuario();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
