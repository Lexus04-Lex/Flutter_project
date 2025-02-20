import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailAndPassword(String email, String password)async {
    return _supabase.auth.signInWithPassword(password: password);

  }

  Future<void> signUp(String username, String password, String fullname, String email)async {

    final response = await _supabase.auth.signUp( email: email, password: password);

    //Storing user data into supabase
if(response.user !=null){
    await _supabase.from('profiles').insert({
      // 'id': response.user!.id,
      'username': username,
      'fullname': fullname,
      'email': email,
      'profilepic': null,
      'createdat': DateTime.now().toIso8601String(),

  });
} else{
  throw Exception('Sign Up failed');
}
  }
  
  Future<void> logout()async {
    await _supabase.auth.signOut();
  }

  Future<void> resetPasswordForEmail(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  String? getCurrentUserEmail(){
    final session = _supabase.auth.currentSession;

    final user = session?. user;

    return user?.email;
  }
  }