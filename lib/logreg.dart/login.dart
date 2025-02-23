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

  /// **🔥 Modified Login Function**
  void login() async {
    final username = _username.text.trim();
    final password = _password.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both username and password')),
      );
      return;
    }

    try {
      // **Step 1: Get the email linked to the username**
      final response = await authservice.getEmailFromUsername(username);

      if (response == null) {
        throw Exception('Username not found');
      }

      final email = response; // The retrieved email

      // **Step 2: Sign in using email & password**
      await authservice.signInWithEmailAndPassword(email, password);

      // **Step 3: Navigate to Home Page on success**
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully logged in')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BodyWidget()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error! Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
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
              controller: _password,
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
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Reset()),
                  ),
                  child: Text('Forgot password?'),
                ),
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
