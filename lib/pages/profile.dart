import 'package:flutter/material.dart';
import 'package:weconnect/pages/home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
                        Row(
                children: [
                  Container(
                        child: BodyWidget(),
                  )
                ],
              ),
        ],
      ),
          
    );
  }
}