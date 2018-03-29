import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'FirstTab.dart' as first;
import 'SecondTab.dart' as second;
import 'ThirdTab.dart' as third;

class TabLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TabLayoutState();
  }
}

class TabLayoutState extends State<TabLayout>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tab Layout"),
        bottom: defaultTargetPlatform == TargetPlatform.android
            ? _getTabBar()
            : null,
      ),
      bottomNavigationBar:
          defaultTargetPlatform == TargetPlatform.iOS ? _getBottomBar() : null,
      body: new TabBarView(controller: _controller, children: <Widget>[
        new first.FirstTab(),
        new second.SecondTab(),
        new third.ThirdTab(),
      ]),
    );
  }

  _getBottomBar() {
    return new Material(
      child: _getTabBar(),
    );
  }

  _getTabBar() {
    return new TabBar(controller: _controller, tabs: _getTabs());
  }

  _getTabs() {
    return <Tab>[
      new Tab(
        icon: new Icon(Icons.arrow_forward),
      ),
      new Tab(
        icon: new Icon(Icons.arrow_downward),
      ),
      new Tab(
        icon: new Icon(Icons.arrow_drop_down_circle),
      ),
    ];
  }
}
