import 'package:flutter/material.dart';
import 'package:weconnect/pages/home.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }

  }

  class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.cyanAccent,
        title: Text('My App'),
      ),
      body: const BodyWidget(),
    );
  }
}