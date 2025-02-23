import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
  final SupabaseClient _supabase = Supabase.instance.client;

Future<String?> getEmailForUsername(String username) async {
  final response = await _supabase
      .from('profiles')
      .select('email') 
      .eq('username', username)
      .maybeSingle();

      return response?['email'];
}

Future<AuthResponse> signUp(String username, String email, String password, String fullname) async {
  try {
    final AuthResponse response = await _supabase.auth.signUp(email:email, password:  password);

    if(response.user == null){
      throw Exception("Sign-up failed: No user object returned");
    }
        final String userId = response.user!.id;

         final List existingUsers = await _supabase
          .from('profiles')
          .select('username')
          .eq('username', username);

          if(existingUsers.isNotEmpty){
            throw Exception('Username already taken. Choose a different one.');
          }

          await _supabase.from('profiles')
          .insert({
            'user_id': userId,
            'username': username,
            'fullname': fullname.isNotEmpty ? fullname : null,
            'email': email,
            'created_at': DateTime.now().toIso8601String(),
          });
      
    
  } catch (e){
    throw Exception('Sign-up failed: $e');
  }
}
}