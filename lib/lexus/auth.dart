import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
  final SupabaseClient _supabase = Supabase.instance.client;


//Function to fetch username and its related email
  Future<String?> getEmailFromUsername(String username)async {
    final response = await _supabase
    .from('profiles')
    .select('username')
    .eq('username', username)
    .maybeSingle();

    return response?['email'];
  }


  //Function to allow new user sign up
  Future<void> signUp(String fullname, String email, String username, String password) async {
    try{
     final response = await _supabase.auth.signInWithPassword(password: password, email: email);
      if(response.user == null){
        throw Exception('User account could not be created? Try again');

      }
      final List existingUsers = await _supabase
        .from('profiles')
        .select('username')
        .eq('username', username);

//An if statement to check if username entered by user is already taken
        if(existingUsers.isNotEmpty){
          throw Exception("Username already taken, try a different one");

        }
        
      final  userId = response.user?.id;

      //Function to insert data of new user in the database upon successful user account creation
      await _supabase
      .from('profiles')
      .insert({
      'user_id', userId, 
      'fullname', fullname,
      'email',email,
      'username',username,
      'created_at', DateTime.now().toIso8601String()
      });
  } catch(e){
    throw Exception('Error? $e');
  }
  }

  //Function to allow user log in 
  Future<AuthResponse> signIn(String email, String password)async {
     return await _supabase.auth.signInWithPassword(password: password, email: email);
  }

  //Function to allow user sign out
  Future<void> logOut()async {
    await _supabase.auth.signOut();
  }

  //Function to allow password recovery
  Future<void> resetPasswordForEmail(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  //Function to handle fetching of each user email
  String? getCurrentUserEmail(){
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

}