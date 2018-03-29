import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.cyanAccent,
      child: new Center(
        child: new Icon(
          Icons.accessibility_new,
          size: 150.0,
          color: Colors.brown,
        ),
      ),
    );
  }
}
