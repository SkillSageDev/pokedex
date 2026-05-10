import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<User?> get authStateChanged => _auth.authStateChanges();

  static User? get currentUser => _auth.currentUser;

  static Future signUp(String email, String password) async => await _auth
      .createUserWithEmailAndPassword(email: email, password: password);

  static Future<UserCredential> logIn(String email, String password) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  static Future<void> logOut() async => await _auth.signOut();
}
