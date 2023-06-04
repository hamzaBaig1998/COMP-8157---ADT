import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:w_class/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  final String accountType;

  ProfilePage(this.accountType);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userReference = FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String badgeType;
  late UserModel currentUser;


  @override
  void initState() {
    _setBadgeType();
    super.initState();

  }



  _setBadgeType() {
    if (widget.accountType == "Trash Picker") {
      badgeType = "Picker";
    } else if (widget.accountType == "Trash Collector") {
      badgeType = "Collector";
    }
  }

  _statTitle(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          fontWeight: FontWeight.bold),
    );
  }

  _statDetail(double numberValue, bool isDouble) {
    String detailString;
    if (isDouble) {
      detailString = numberValue.toString();
    } else {
      detailString = numberValue.toInt().toString();
    }

    return Text(
      detailString,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          fontWeight: FontWeight.bold),
    );
  }

  _badgeRequiresPoints(String points) {
    return Text(
      points,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
          fontWeight: FontWeight.normal),
    );
  }

  _badgeDesignsWidget(String image, String badgeName, String badgePoints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 60.0,
          width: 60.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statTitle(badgeName),
            _badgeRequiresPoints(badgePoints),
          ],
        )
      ],
    );
  }

  welcomeHeader() {
    var firstName='Arjun';
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .where('uuid', isEqualTo: "${auth.currentUser?.uid}")
          .snapshots(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          //return profileHeaderShimmer();

          return Text(
            "Hi! ${firstName}",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                fontWeight: FontWeight.bold),
          );
        } else {

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi! ${firstName}",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.normal),
              ),
            ],
          );
        }
      },
    );
  }

  _profileStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _statTitle("Total Trash Throws"),
                SizedBox(
                  height: 10.0,
                ),
                _statTitle("Total Points"),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _statDetail(4, false),
                SizedBox(
                  height: 10.0,
                ),
                _statDetail(52, false),
              ],
            )
          ],
        ),
        Column(
          children: [
            Image.asset(
              'assets/images/badge_starter.png',
              height: 70.0,
              width: 70.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            _statTitle("Starter\n$badgeType"),
          ],
        )
      ],
    );
  }

  _badgeDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.accountType == "Trash Picker"
            ? _statTitle("Keep going for more recyclable trash to unlock the,")
            : _statTitle("Collect more trash to unlock the,"),
        SizedBox(
          height: 10.0,
        ),
        _badgeDesignsWidget('assets/images/badge_bronze.png',
            "Bronze $badgeType", "100 Points"),
        SizedBox(
          height: 10.0,
        ),
        _badgeDesignsWidget('assets/images/badge_silver.png',
            "Silver $badgeType", "1000 Points"),
        SizedBox(
          height: 10.0,
        ),
        _badgeDesignsWidget(
            'assets/images/badge_gold.png', "Gold $badgeType", "10000 Points"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.green),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/logos/trashpick_logo_curved.png',
                  height: 75.0,
                  width: 75.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                welcomeHeader(),
                Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize:
                        Theme.of(context).textTheme.headlineSmall?.fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
/*                Text(
                  "${widget.accountType}",
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline4.fontSize,
                      fontWeight: FontWeight.bold),
                ),*/
                _profileStats(),
                SizedBox(
                  height: 30.0,
                ),
                _badgeDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
