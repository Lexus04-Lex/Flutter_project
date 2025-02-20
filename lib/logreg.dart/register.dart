// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weconnect/auth/auth.dart';
import 'package:weconnect/logreg.dart/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:email_validator/email_validator.dart';

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
  final username = _username.text.trim();
  final password = _password.text.trim();
  final email = _email.text.trim();
  final fullname = _fullname.text.trim();
  final confirm = _confirm.text.trim();

  if (!EmailValidator.validate(email)) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Invalid email format')));
    return;
  }

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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
          child: Column(children: [
              //Username Field
              TextField(
                controller: _fullname,
                decoration: InputDecoration(
                  
                  border: OutlineInputBorder(),
                  label: Text('Enter your Full name'),
                  
                ),
              ),
              const SizedBox(height: 10),

              //PasswordField
                TextField(
                controller: _email,
                enableSuggestions: true,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter your email'), 
                  
                ),
                ),
                const SizedBox(height: 10),

                TextField(
                controller: _username,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter your username'),
                  
                ),
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter your password'),
                  
                ),
              ),
              const SizedBox(height: 10),

                TextField(
                controller: _confirm,
                obscureText: true,
                
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter your password again'),
                  
                ),
              ),
              const SizedBox(height: 10),
              //Register button
              ElevatedButton(onPressed: register, 
              child: Center(child: Text('Register',
              
              )),
              
              ),
              //Option to go back to login page
              TextButton(onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> const Loginpage())),
               child: Center(child: Text('Already have an account? log in')),
               ),
            ],
          ),
          ),
        ],
      ),
      );
    
  }
}