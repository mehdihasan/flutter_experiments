import 'package:flutter/material.dart';
import 'package:my_flutter_chat/frienddetails/footer/friend_detail_footer.dart';
import 'package:my_flutter_chat/frienddetails/friend_detail_body.dart';
import 'package:my_flutter_chat/frienddetails/header/friend_detail_header.dart';
import 'package:my_flutter_chat/friends/friend.dart';
import 'package:meta/meta.dart';

class FriendDetailsPage extends StatefulWidget {
  FriendDetailsPage(
    this.friend, {
    @required this.avatarTag,
  });

  final Friend friend;
  final Object avatarTag;

  @override
  _FriendDetailsPageState createState() => new _FriendDetailsPageState();
}

class _FriendDetailsPageState extends State<FriendDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = new BoxDecoration(
      gradient: new LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: [
          const Color(0xFF413070),
          const Color(0xFF2B264A),
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new FriendDetailHeader(
                widget.friend,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new FriendDetailBody(widget.friend),
              ),
              new FriendShowcase(widget.friend),
            ],
          ),
        ),
      ),
    );
  }
}
