import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(microseconds: 500));
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("images/logo.png"),
            fit: BoxFit.cover,
            color: Colors.black87,
            colorBlendMode: BlendMode.darken,
          ), // BG Image
          new Theme(
            data: new ThemeData(
                brightness: Brightness.dark,
                inputDecorationTheme: new InputDecorationTheme(
                  // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                  labelStyle:
                      new TextStyle(color: Colors.tealAccent, fontSize: 25.0),
                )),
            isMaterialAppTheme: true,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FlutterLogo(
                  size: _iconAnimation.value * 140.0,
                ),
                new Container(
                  padding: const EdgeInsets.all(40.0),
                  child: new Form(
                    autovalidate: true,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new TextFormField(
                          decoration: new InputDecoration(
                              labelText: "Enter Email",
                              fillColor: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Password",
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                        ),
                        new MaterialButton(
                          height: 50.0,
                          minWidth: 150.0,
                          color: Colors.green,
                          splashColor: Colors.teal,
                          textColor: Colors.white,
                          child: new Icon(FontAwesomeIcons.signInAlt),
                          // child: new Text("Login"),
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new HomePage()));
                          },
                        )
                      ],
                    ), // form child column
                  ), // form
                ) // container
              ],
            ), // theme child column
          ), // theme
        ],
      ),
    ); // Scaffold
  } // Widget

}
