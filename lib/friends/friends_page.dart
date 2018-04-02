import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_chat/frienddetails/friend_details_page.dart';
import 'package:my_flutter_chat/friends/friend.dart';
import 'package:my_flutter_chat/friends/contacts_demo.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => new _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  List<Friend> _friends = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  _loadFriends() async {
    String response =
        await createHttpClient().read('https://randomuser.me/api/?results=25');

    setState(() {
      _friends = Friend.allFromResponse(response);
    });
  }

  _buildFriendItem(BuildContext context, int index) {
    Friend friend = _friends[index];

    return new ListTile(
      onTap: () => _navigateToFriendDetails(friend, index),
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(friend.avatar),
        ),
      ),
      title: new Text(friend.name),
      subtitle: new Text(friend.email),
    );
  }

  _navigateToFriendDetails(Friend friend, Object avatarTag) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          //return new ContactsDemo();
          return new FriendDetailsPage(friend, avatarTag: avatarTag);
        },
      ),
    );
  }

  _showMaterialSearch(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    var content;

    if (_friends.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: _friends.length,
        itemBuilder: _buildFriendItem,
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Friends'),
        actions: <Widget>[
          new IconButton(
            onPressed: () {
              _showMaterialSearch(context);
            },
            tooltip: 'Search',
            icon: new Icon(Icons.search),
          )
        ],
      ),
      body: content,
    );
  }
}
