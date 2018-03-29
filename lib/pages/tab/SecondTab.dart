import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.blueGrey,
      child: new Center(
        child: new Icon(
          Icons.local_pizza,
          size: 150.0,
          color: Colors.red,
        ),
      ),
    );
  }
}
