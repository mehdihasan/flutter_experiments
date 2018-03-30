import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'pages/login.dart';
import 'ui/home/home_page.dart';

void main() =>
    runApp(
      /*new MaterialApp(
    theme: defaultTargetPlatform == TargetPlatform.iOS
        ? kIOSTheme
        : kDefaultTheme,
    home: new LoginScreen(),
  )*/
      new MaterialApp(
        title: "Planets",
        home: new HomePage(),
      ),
    );

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);
