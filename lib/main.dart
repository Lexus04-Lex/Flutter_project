import 'package:flutter/material.dart';
import 'package:weconnect/pages/settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:weconnect/auth/authgate.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://uyjedkojbrwwguwrzmwb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV5amVka29qYnJ3d2d1d3J6bXdiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAwNjUzNzIsImV4cCI6MjA1NTY0MTM3Mn0.5h9YNs1RlUJFuyaIEuWku8KIpSYUT6DBlVrfR8Go1ms',

  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData(),
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
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