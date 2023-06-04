import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:w_class/model/profile.dart';

import 'ProfilePage.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final _biggerFont = const TextStyle(fontSize: 14.0);
  List<Profile> profiles = [
    new Profile("Hamza", 2300, true),
    new Profile("Meet", 2500, true),
    new Profile("Arjun", 500, true),
    new Profile("Himani", 400, true),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("ADT project"),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Enter a name to search',
              ),
            ),
          ),
          Text(
            "Your current friends",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          Expanded(child: _buildTiles())
        ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage("Trash Picker")));
        },
        child: Icon(Icons.person,color: Colors.green ),
        backgroundColor: Colors.white,
      ),);
  }

// Current friends list.
  Widget _buildRow(Profile profile, i) {
    return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.account_circle, size: 35),
          title: new Text(
            profile.name,
            style: _biggerFont,
          ),
          // subtitle:
          //     new Text("${profile.friend_flag ? "Friend" : "Not Friend"}"),
          trailing: new Text("${profile.score}"),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          horizontalTitleGap: 5.0,
          minVerticalPadding: 25.0,
        ));
  }

  Widget _buildTiles() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: profiles.length,
      itemBuilder: (context, i) {
        return _buildRow(profiles[i], i);
      },
    );
  }
}
