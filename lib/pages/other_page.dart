import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  final String pageTitle;

  OtherPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(pageTitle),
      ),
      body: new Center(
        child: new Text(pageTitle),
      ),
    );
  }
}
