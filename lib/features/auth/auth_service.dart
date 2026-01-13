import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'local_user_repository.dart';

class AuthService {
  static const _webClientId =
      String.fromEnvironment('GOOGLE_SIGN_IN_WEB_CLIENT_ID');

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

  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb && _webClientId.isEmpty) {
        throw StateError(
          'Falta configurar GOOGLE_SIGN_IN_WEB_CLIENT_ID para el inicio de sesión web.',
        );
      }
      final googleSignIn = GoogleSignIn(
        clientId: kIsWeb && _webClientId.isNotEmpty ? _webClientId : null,
      );
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw StateError('Inicio de sesión con Google cancelado.');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      throw StateError(error.message ?? error.toString());
    } on StateError {
      rethrow;
    } on Exception catch (error) {
      throw StateError(
        'No se pudo iniciar sesión con Google. ${error.toString()}',
      );
    }
  }

  bool get hasCurrentUser => FirebaseAuth.instance.currentUser != null;

  Future<void> signOut() async {
    await _localUserRepository.borrarUsuario();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
