import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context){
  

    return MaterialApp(
      
      theme: ThemeData(
              
      ),
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
  class Homepage extends StatelessWidget{
    const Homepage({super.key});

    @override
    Widget build(BuildContext context){
      final title = 'Lexus';
      return Scaffold(
        appBar: AppBar(title: Text(title),),
        body: Column(
          children: [
            Text('Good morning'),
          ],
        ),
      );

    }

  }
