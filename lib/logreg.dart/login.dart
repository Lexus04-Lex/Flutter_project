// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weconnect/auth/auth.dart';
import 'package:weconnect/pages/home.dart';
import 'package:weconnect/logreg.dart/register.dart';
import 'package:weconnect/logreg.dart/reset.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final authservice = AuthService();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  void login() async {
    final username = _username.text;
    final password = _password.text;

    try {
      await authservice.signInWithEmailAndPassword(username, password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully logged in')));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const BodyWidget()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error! log in failed $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrap everything inside a Scaffold
      appBar: AppBar(title: Text("Login")), // Optional AppBar for UI consistency
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username Field
            TextField(
              controller: _username,
              decoration: InputDecoration(
                labelText: 'Enter your username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // Password Field
            TextField(
              controller: _password, // This should be _password, not _username
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // Log in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: login,
                child: Text('Log in'),
              ),
            ),

            SizedBox(height: 15),

            // Option to reset password or sign up if one doesn't have an account
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Reset password link
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Reset()),
                  ),
                  child: Text('Forgot password?'),
                ),

                // Sign up button for new user
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                  ),
                  child: Text("Don't have an account? Sign up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
