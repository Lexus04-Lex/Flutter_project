import 'package:flutter/material.dart';
import 'package:weconnect/lexus/auth.dart';
import 'package:weconnect/pages/menu.dart';
import 'package:weconnect/pages/profile.dart';
import 'package:weconnect/pages/settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final authservice = AuthService();
  int _selectedIndex = 0;
  late String username = '';
  late String useremail = '';
  late final List<Widget> _pages;
  
  @override
  void initState() {
    super.initState();
    _pages = [
      Homepage(),
      Menu(),
      Profile(),
      Settings(),
    ];
    _fetchUserProfile();
  }

  void _fetchUserProfile()async {
    final user = Supabase.instance.client.auth.currentUser;
    if(user != null ){
      final response = await Supabase.instance.client
      .from('profiles')
      .select('username, email')
      .eq('user_id', user.id)
      .maybeSingle();

      if(response != null && response.isNotEmpty){
        setState(() {
          username = response['username'] ?? 'Name not available';
          useremail = response['email'] ?? 'Email not available';
        });
      } else {
        setState(() {
          username = 'Name not available';
          useremail = 'Email not available';
        });
    }}}
    void _onItemtapped(int index){
      setState(() {
        _selectedIndex = index;
      });
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    useremail,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Menu'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // ListTile(
            //   title: const Text('Log Out'),
            //   onTap: () {
            //     authservice.signOut();
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedFontSize: 20,
        selectedItemColor: Colors.blueGrey,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemtapped,
      ),
    );
  }
}