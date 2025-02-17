import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Get the currently signed-in user
  User? get currentUser => _firebaseAuth.currentUser;

  // Stream to listen for auth state changes (login/logout)
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Existing user log in function
  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return null; // No errors
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    } catch (e) {
      return "An unexpected error occurred. Please try again.";
    }
  }

  // New user sign up function
  Future<String?> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "An unexpected error occurred. Please try again.";
    }
  }

  // Reset password function
  Future<String?> resetPasswordForEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null; // No errors
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "An unexpected error occurred. Please try again.";
    }
  }

  // Sign out function
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
