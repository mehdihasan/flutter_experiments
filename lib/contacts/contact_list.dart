import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_chat/contacts/contacts.dart';
import 'package:my_flutter_chat/contacts/contacts_demo.dart';
import 'search_helper.dart';

class ContactsPage extends StatefulWidget {
  @override
  _FContactsPageState createState() => new _FContactsPageState();
}

class _FContactsPageState extends State<ContactsPage> {
  List<Contacts> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  _loadContacts() async {
    String response =
        await createHttpClient().read('https://randomuser.me/api/?results=25');

    setState(() {
      _contacts = Contacts.allFromResponse(response);
    });
  }

  _buildFriendItem(BuildContext context, int index) {
    Contacts contact = _contacts[index];

    return new ListTile(
      onTap: () => _navigateToContactDetails(contact, index),
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(contact.avatar),
        ),
      ),
      title: new Text(contact.name),
      subtitle: new Text(contact.email),
    );
  }

  _navigateToContactDetails(Contacts friend, Object avatarTag) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (c) {
          return new ContactsDemo();
        },
      ),
    );
  }

  _buildMaterialSearchPage(BuildContext context) {
    return new MaterialPageRoute<String>(
        settings: new RouteSettings(
          name: 'material_search',
          isInitialRoute: false,
        ),
        builder: (BuildContext context) {
          return new Material(
            child: new MaterialSearch<Contacts>(
              placeholder: 'Search',
              results: _contacts
                  .map((Contacts v) => new MaterialSearchResult<Contacts>(
                        value: v,
                      ))
                  .toList(),
              filter: (Contacts value, String criteria) {
                return value.name.toLowerCase().trim().contains(
                    new RegExp(r'' + criteria.toLowerCase().trim() + ''));
              },
              //onSelect: (String value) => Navigator.of(context).pop(value),
            ),
          );
        });
  }

  _showMaterialSearch(BuildContext context) {
    Navigator
        .of(context)
        .push(_buildMaterialSearchPage(context))
        .then((Object value) {
      setState(() => _contacts = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var content;

    if (_contacts == null) {
      _contacts = [];
      _loadContacts();
    }

    if (_contacts.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: _contacts.length,
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
