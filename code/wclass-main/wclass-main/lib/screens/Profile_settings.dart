import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:w_class/model/Profile.dart';
import 'package:flutter/material.dart';

class ProfileViewPage extends StatefulWidget {
  const ProfileViewPage({super.key});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  final _biggerFont = const TextStyle(fontSize: 14.0);
  Profile profile = new Profile("Shafaq Khan", 400, false);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("ADT project"),
        ),
        body: Column(children: <Widget>[Expanded(child: _buildRow(profile))]));
  }

// Current friends list.
  Widget _buildRow(Profile profile) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.account_circle, size: 75.0)],
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(profile.name)],
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Unlocked Achievements",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.access_time),
            Icon(Icons.fast_forward),
            Icon(Icons.place),
          ],
        ),
      ],
    );
  }
}
