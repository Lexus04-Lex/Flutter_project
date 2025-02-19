// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weconnect/auth/auth.dart';
import 'package:weconnect/logreg.dart/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final SupabaseClient _supabase = Supabase.instance.client;

    final authservice = AuthService();
    final _username = TextEditingController();
    final _password = TextEditingController();
    final _email = TextEditingController();
    final _fullname = TextEditingController();
    final _confirm = TextEditingController();
    @override
    void dispose(){
      _username.dispose();
      _fullname.dispose();
      _email.dispose();
      _password.dispose();
      _confirm.dispose();
      super.dispose();
    }

void register()async {
  final username = _username.text;
  final password = _password.text;
  final email = _email.text;
  final fullname = _fullname.text;
  final confirm = _confirm.text;

  if(password != confirm){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords don\'t match')));
  }


  if (password != confirm) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords don\'t match')));
    return;
  }

  try {
    // Check if the username already exists in the database
    final response = await _supabase
        .from('profiles') // Assuming 'users' is your table where usernames are stored
        .select('username')
        .eq('username', username)
        .single()
        .maybeSingle();

    if (response != null) {
      // Username already exists
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username is already taken')));
      return;
    }

    // Proceed with user registration if username is available
    await authservice.signUp(username, password, fullname, email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up successful')));
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Loginpage()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error! sign up failed $e')));
  }
}


 /* try{
    await authservice.signUp(username, password, fullname, email,);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up successful')));
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Loginpage()));

  } catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error! sign up failed $e')));
  }
}
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold
    ( 
      appBar: AppBar(title: Text('Register'),
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20),
      ),
      body: Padding(padding: EdgeInsets.all(25),

        child: Column(
          children: [
            //Username Field
            TextField(
              controller: _fullname,
              decoration: InputDecoration(
                label: Text('Enter your Full name'),
                
              ),
            ),
            //PasswordField
              TextField(
              controller: _email,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                label: Text('Enter your email'), 
                
              ),
              ),
                        TextField(
              controller: _username,
              decoration: InputDecoration(
                label: Text('Enter your username'),
                
              ),
            ),
                      TextField(
              controller: _password,
              decoration: InputDecoration(
                label: Text('Enter your password'),
                
              ),
            ),
                      TextField(
              controller: _confirm,
              decoration: InputDecoration(
                label: Text('Enter your password again'),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}