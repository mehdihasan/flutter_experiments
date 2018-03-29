import 'package:flutter/material.dart';

class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.amberAccent,
      child: new Center(
        child: new Icon(
          Icons.favorite,
          size: 150.0,
          color: Colors.teal,
        ),
      ),
    );
  }
}
