// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weconnect/auth/auth.dart';
import 'package:weconnect/logreg.dart/login.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final _email = TextEditingController();
  final authservice = AuthService();

  @override
  void dispose() async {
    super.dispose();
    _email.dispose();
  }

  void reset() async {

    final email = _email.text;

    try{

      await authservice.resetPasswordForEmail(email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password reset successfully')));
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Loginpage()));

    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error! could not reset password')));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding:EdgeInsets.only(left: 35),
      
        child: Column(
          children: [
            //Email Field
            TextField(
              controller: _email,
              decoration: InputDecoration(label: Text('Enter your email')),
              enableSuggestions: false,
              autocorrect: false,
            ),
            //Reset button
            ElevatedButton(onPressed: reset,
             child: Text('Reset your password')),
          ],
        ),
      
      ),
    );
  }
}