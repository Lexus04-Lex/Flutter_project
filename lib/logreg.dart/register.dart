// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:weconnect/logreg.dart/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:weconnect/pages/authservice.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final SupabaseClient _supabase = Supabase.instance.client;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _confirm = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _fullname.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> register() async {
    final username = _username.text.trim();
    final password = _password.text.trim();
    final email = _email.text.trim();
    final fullname = _fullname.text.trim();
    final confirm = _confirm.text.trim();

    if (!EmailValidator.validate(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email format')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      // Step 1: Create the user in Supabase Auth
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw 'User creation failed. Please try again.';
      }

      final String userId = response.user!.id;

      // Step 2: Insert user details into 'profiles' table
      await _supabase.from('profiles').insert({
        'user_id': userId,
        'username': username,
        'fullname': fullname.isNotEmpty ? fullname : null,
        'email': email,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-up successful!')),
      );

      // Step 3: Navigate to Login Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginpage()),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          TextField(
            controller: _fullname,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your full name',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _username,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your username',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _confirm,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirm your password',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: register,
            child: const Center(child: Text('Register')),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Loginpage()),
              );
            },
            child: const Center(child: Text('Already have an account? Log in')),
          ),
        ],
      ),
    );
  }
}
