import 'package:flutter/material.dart';
import 'package:weconnect/main.dart';
import 'package:weconnect/pages/homepage.dart';
import 'package:weconnect/pages/menu.dart';
import 'package:weconnect/pages/profile.dart';
import 'package:weconnect/pages/settings.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
    int _selectedIndex = 0;

    late final List<Widget> _pages;

    @override
    void initState(){
      super.initState();
      _pages = [
        //Home page
        Home(),

        //Menu page

        Menu(),

        //About page
        Profile(),

        //Settings page
        Settings(),

      ];
    }

    // @override
    void _onItemtapped(int index){
      setState(() {
        _selectedIndex = index;
      });
    }
  @override
  Widget build(BuildContext context) {
    final String title = "Lexus";
    return Scaffold(
      appBar: MyAppBar(title: title),
               drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 77, 129, 219),
          elevation: 10.0,
          child: ListView(
            padding: EdgeInsets.only(left: 25, right: 25),
            children: [
              UserAccountsDrawerHeader(
                
                accountName: Text('Isabirye Alex'),
                accountEmail: Text('isabiryealexx@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/images/c5.jpeg'),
                ), 
                decoration: BoxDecoration(color: const Color.fromARGB(255, 15, 32, 32)),
              ),

              
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),

              ),

              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),

              ),
            ],
            
          ),
          
         ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedFontSize: 20,
        selectedItemColor: Colors.blueGrey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: 'Home',
          
          
          ),

          BottomNavigationBarItem(icon: Icon(Icons.menu),
          label: 'Shop'
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person),
          label: 'Profile'
          ),

          // BottomNavigationBarItem(icon: Icon(Icons.person),
          // label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemtapped,
        
         ),

    );
  }
}