import 'package:flutter/material.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello')
        ],
      ),
    );
  }
}