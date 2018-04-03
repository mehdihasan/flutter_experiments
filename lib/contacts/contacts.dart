import 'dart:convert';
import 'package:meta/meta.dart';

class Contacts {
  Contacts({
    @required this.avatar,
    @required this.name,
    @required this.email,
    @required this.location,
  });

  final String avatar;
  final String name;
  final String email;
  final String location;

  static List<Contacts> allFromResponse(String jsonString) {
    return json
        .decode(jsonString)['results']
        .map((obj) => Contacts.fromMap(obj))
        .toList();
  }

  static Contacts fromMap(Map map) {
    var name = map['name'];

    return new Contacts(
      avatar: map['picture']['large'],
      name: '${_capitalize(name['first'])} ${_capitalize(name['last'])}',
      email: map['email'],
      location: _capitalize(map['location']['state']),
    );
  }

  static String _capitalize(String input) {
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }
}
