// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weconnect/auth/auth.dart';

class Logpage extends StatefulWidget {
  const Logpage({super.key});

  @override
  State<Logpage> createState() => _LogpageState();
}

class _LogpageState extends State<Logpage> {
  final authservice = AuthService();
  final _username = TextEditingController();
  final _password = TextEditingController();
@override
  void dispose(){
    super.dispose();
    _username.dispose();
    _password.dispose();
  }

  void login()async{
    final username = _username.text.trim();
    final password = _password.text.trim();

    if(username.isEmpty || password.isEmpty ){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Both fields are required')));
      return;
    }

try{
  //Fetch email associated to a specific username
  final response = await authservice.getEmailFromUsername(username);
  
  if(response == null){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not found?')));
    return;
  }
   final email = response;

   //Try sign up
   await authservice.signInWithEmailAndPassword(email, password);
   
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Log in successful')));

} catch (e){

ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Log in failed! check your username and password')));
}
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 25),
          margin: EdgeInsets.only(left: 25),
        
        )
      ],
    );
  }
}