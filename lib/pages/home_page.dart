import 'package:flutter/material.dart';
import './other_page.dart';
import './chat_page.dart';
import 'tab/TabLayout.dart';
import 'search_page.dart';
import 'package:my_flutter_chat/ui/home/home_page.dart';
import 'package:my_flutter_chat/friends/friends_page.dart';
import 'package:my_flutter_chat/contacts/contact_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String currentProfilePic =
      "https://avatars2.githubusercontent.com/u/7582987?s=460&v=4";
  String background =
      "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg";

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Cefalo Drawer App"),
        backgroundColor: Colors.redAccent,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Mehdi Hasan",
                  style: new TextStyle(color: Colors.white)),
              accountEmail: new Text("mehdi@cefalo.com",
                  style: new TextStyle(color: Colors.white)),
              currentAccountPicture: new GestureDetector(
                onTap: () => debugPrint("this is my test on tap"),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(currentProfilePic),
                ),
              ),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill, image: new NetworkImage(background))),
            ),
            new ListTile(
              title: new Text("First Page"),
              trailing: new Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new OtherPage("First Page")));
              },
            ),
            new ListTile(
              title: new Text("Second Page"),
              trailing: new Icon(Icons.people),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new OtherPage("Second Page")));
              },
            ),
            new ListTile(
              title: new Text("Chat"),
              trailing: new Icon(Icons.photo),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new ChatScreen()));
              },
            ),
            new ListTile(
              title: new Text("Tabs"),
              trailing: new Icon(Icons.tab),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new TabLayout()));
              },
            ),
            new ListTile(
              title: new Text("Search"),
              trailing: new Icon(Icons.search),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Search()));
              },
            ),
            new ListTile(
              title: new Text("Planet"),
              trailing: new Icon(Icons.satellite),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new Solar()));
                /*Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Solar()));*/
              },
            ),
            new ListTile(
              title: new Text("Friends"),
              trailing: new Icon(Icons.people),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new FriendsPage()));
              },
            ),
            new ListTile(
              title: new Text("Contacts"),
              trailing: new Icon(Icons.contacts),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new ContactsPage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Cancel"),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
