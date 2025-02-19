import 'package:flutter/material.dart';
import 'package:weconnect/pages/home.dart';
import 'package:weconnect/pages/settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xkufmazhwkemukcnsgsr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhrdWZtYXpod2tlbXVrY25zZ3NyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgzMjI2MTYsImV4cCI6MjA1Mzg5ODYxNn0.KFfpRmIyRfHALLFD49sFurizzSLkdPNEeHyfiEGlA7k',

  );
  

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(),
      home: const Homepage(
        
      ),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
  }
  class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // final  title= '';
    return Scaffold(
      

      // appBar: MyAppBar(title: title),
    
      body: const BodyWidget()
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double headerheight = 70.0;
  const MyAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(headerheight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      backgroundColor: Colors.grey,
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: ()=> Navigator.push(context,
           MaterialPageRoute(builder: 
           (context)=> const Settings())), 
           icon: Icon(Icons.settings),
           
           )
      ],
      
    );
  }
}