import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FirstPageState();
  }
}

class FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("First Page"),
      ),
    );
  }
}
