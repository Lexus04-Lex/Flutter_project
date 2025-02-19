import 'package:flutter/material.dart';
import 'package:weconnect/main.dart';
import 'package:weconnect/pages/homepage.dart';
import 'package:weconnect/pages/menu.dart';
import 'package:weconnect/pages/profile.dart';
import 'package:weconnect/pages/settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  late String userName = '';
  late String userEmail = '';

  @override
  void initState() {
    super.initState();
    _pages = [
      Home(),
      Menu(),
      Profile(),
      Settings(),
    ];
    _fetchUserProfile();
  }

  // Fetch user profile from Supabase
  void _fetchUserProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      final response = await Supabase.instance.client
          .from('profiles') // Assuming 'profiles' is the table where the user info is stored
          .select('name, email')
          .eq('user_id', user.id) // Make sure to query based on user_id or any unique identifier
          .maybeSingle();

      if (response != null && response.isNotEmpty) {
        setState(() {
          userName = response['name'] ?? 'Name not available';
          userEmail = response['email'] ?? 'Email not available';
        });
      } else {
        // Handle error if no profile is found
        setState(() {
          userName = 'Name not available';
          userEmail = 'Email not available';
        });
      }
    }
  }

  void _onItemtapped(int index) {
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
              accountName: Text(userName),
              accountEmail: Text(userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/images/c5.jpeg'),
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 15, 32, 32),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemtapped,
      ),
    );
  }
}
