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
        appBar: AppBar(title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 10,
        ),
        body: Container(
          color: Colors.amber,
          height: 100,
          width: 200,
          margin: EdgeInsets.fromLTRB(10, 40, 30, 50),
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              
            
              children: [
                
                Text('Good morning',
                style: TextStyle(

                  // decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 18,
                  fontStyle: FontStyle.italic,

                ),
                ),
              ],
            ),
          ),
        ),
      );

    }

  }
