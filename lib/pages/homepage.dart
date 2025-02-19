// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:weconnect/pages/createpost.dart';
// import 'package:weconnect/pages/post_service.dart';
// import 'package:weconnect/pages/post_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Createpostpage(),
    );
    
  }
}