import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// **🔥 Fetch Email from Username**
  Future<String?> getEmailFromUsername(String username) async {
    final response = await _supabase
        .from('profiles')
        .select('email')
        .eq('username', username)
        .maybeSingle(); // Fetch single row

    return response?['email']; // Return email or null
  }

  /// **🔥 Fixed: Sign In with Email & Password**
  Future<AuthResponse> signInWithEmailAndPassword(String email, String password) async {
    return await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  /// **🔥 Sign Up with Additional Profile Insertion**
  Future<void> signUp(String username, String password, String fullname, String email) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);

      if (response.user == null) {
        throw Exception('Sign Up failed: No user object returned');
      }

      final String userId = response.user!.id;

      // Check for duplicate usernames
      final List existingUsers = await _supabase
          .from('profiles')
          .select('username')
          .eq('username', username);

      if (existingUsers.isNotEmpty) {
        throw Exception('Username already taken. Choose a different one.');
      }

      // Insert User Details into 'profiles' Table
      await _supabase.from('profiles').insert({
        'user_id': userId,
        'username': username,
        'fullname': fullname.isNotEmpty ? fullname : null,
        'email': email,
        'created_at': DateTime.now().toIso8601String(),
      });

    } catch (e) {
      throw Exception('Sign-up failed: $e');
    }
  }

  /// **🔥 Logout Function**
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// **🔥 Reset Password**
  Future<void> resetPasswordForEmail(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  

  /// **🔥 Get Current User Email**
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
