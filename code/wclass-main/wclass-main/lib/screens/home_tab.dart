import 'package:firebase_auth/firebase_auth.dart';
import 'package:w_class/model//Profile.dart';
import 'package:w_class/model//Notification.dart' as Notification_message;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:w_class/screens/pickup_pdf.dart';

import 'Profile_settings.dart';
import 'login_screen.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Profile current_profile = new Profile("Hamza Baig", 4000, true);
  List<Profile> profiles = [
    new Profile("Hamza", 2300, true),
    new Profile("Meet", 2500, true),
    new Profile("Arjun", 500, true),
    new Profile("Himani", 400, true),
    new Profile("Ali", 200, false),
  ];
  final _biggerFont = const TextStyle(fontSize: 14.0);
  Notification_message.Notification notification =
  new Notification_message.Notification(
      "27th March 2023", "The trash can will be emptied at 11.00 am");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("ADT project"),
          actions: [
      IconButton(icon: Icon(Icons.schedule), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyPdfViewer()));
      }),
          PopupMenuButton(
          // add icon, by default "3 dot" icon
          // icon: Icon(Icons.book)
          itemBuilder: (context){
    return [
    PopupMenuItem<int>(
    value: 0,
    child: Text("Schedule"),
    ),

    PopupMenuItem<int>(
    value: 1,
    child: Text("Settings"),
    ),

    PopupMenuItem<int>(
    value: 2,
    child: Text("Logout"),
    ),
    ];
    },
        onSelected:(value){
          if(value == 0){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPdfViewer()));
          }else if(value == 1){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileViewPage()));
          }else if(value == 2){
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        }
    ),
     ]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _currentProfile(current_profile),
          _showNotification(notification),
          Text(
            "Leader's Board",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          Expanded(child: _buildTiles())
        ],
      ),
    );
  }

  Widget _showNotification(Notification_message.Notification notification) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.info, size: 45),
        title: Text(
          notification.date,
          style: TextStyle(fontSize: 14.0),
        ),
        subtitle: Text(notification.message, style: TextStyle(fontSize: 10.0)),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.orangeAccent, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor: Colors.orange,
        textColor: Colors.white,
        iconColor: Colors.white,
        horizontalTitleGap: 15.0,
        minVerticalPadding: 2.0,
      ),
    );
  }

  Widget _currentProfile(Profile profile) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(Icons.account_circle, size: 45),
        title: Text(profile.name),
        subtitle: Text('You are an all star recycler.'),
        trailing: Text("${profile.score}"),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.greenAccent, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        tileColor: Colors.lightGreen,
        textColor: Colors.white,
        iconColor: Colors.white,
        horizontalTitleGap: 20.0,
        minVerticalPadding: 15.0,
      ),
    );
  }

  Widget _buildRow(Profile profile, i) {
    return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(Icons.account_circle, size: 45),
          title: new Text(
            profile.name,
            style: _biggerFont,
          ),
          subtitle:
          new Text("${profile.friend_flag ? "Friend" : "Not Friend"}"),
          trailing: new Text("${profile.score}"),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: i < 3 ? Colors.white : Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          horizontalTitleGap: 14.0,
          minVerticalPadding: 2.0,
          minLeadingWidth: 25.0,
          tileColor: i < 3 ? Colors.lightGreen : Colors.white,
          textColor: i < 3 ? Colors.white : Colors.black,
          iconColor: i < 3 ? Colors.white : Colors.black,
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
