import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registrar usuario
  Future<UserCredential> signUp(String email, String password) {
    return _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // Iniciar sesión
  Future<UserCredential> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // Cerrar sesión
  Future<void> signOut() {
    return _auth.signOut();
  }

  // Enviar correo para restablecer contraseña
  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(email: email.trim());
  }

  // Obtener el usuario actual
  User? get currentUser => _auth.currentUser;

  // Escuchar cambios en la sesión
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
