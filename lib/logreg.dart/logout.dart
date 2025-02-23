// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weconnect/logreg.dart/login.dart';
import 'package:weconnect/auth/auth.dart';
import 'package:weconnect/pages/createpost.dart';

class LogoutPage extends StatelessWidget {
  final authservice = AuthService();

  LogoutPage({super.key});

  void _logout(BuildContext context) async {
    try {
      await authservice.signOut(); // Perform logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully logged out')),
      );
      // Navigate back to login page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Logout")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Are you sure you want to logout?"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _logout(context),
                  child: Text("Yes, Logout"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Createpostpage())),
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
