import 'package:flutter/material.dart';
import 'package:weconnect/pages/home.dart';
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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