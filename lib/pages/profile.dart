// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:todo_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.23),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)
                        )
                    ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 90),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SocialMediaButton(
                              logo: Icon(Ionicons.logo_instagram),
                              color: Colors.pink,
                              url: 'https://instagram.com/gibranoderenz'
                            ),
                            SocialMediaButton(
                              logo: Icon(Ionicons.logo_github),
                              color: Colors.black,
                              url: 'https://github.com/gooseguy88'
                            ),
                            SocialMediaButton(
                              logo: Icon(Ionicons.logo_linkedin),
                              color: Colors.blue,
                              url: 'https://linkedin.com/in/gibrano-derenz'
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 40),
                        Subheader(label: "NAME"),
                        SizedBox(height: 5),
                        UserData(label: "Gibrano Derenz"),
                        SizedBox(height: 20),
                        Subheader(label: "NICKNAME"),
                        SizedBox(height: 5),
                        UserData(label: "Gib"),
                        SizedBox(height: 20),
                        Subheader(label: "HOBBY"),
                        SizedBox(height: 5),
                        UserData(label: "Learning new things"),
                        UserData(label: "Watching football"),
                        SizedBox(height: 20),
                        ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 32,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey[50],
                      child: ClipOval(
                        child: Image.asset(
                          "images/profile-picture.jpg",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover
                          ),
                      )
                    )
                  ),
            ],
          ),
        ));
  }
}

class SocialMediaButton extends StatelessWidget {
  final Icon logo;
  final Color color;
  final String url;
  SocialMediaButton({required this.logo, required this.color, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 51,
      width: 51,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color
      ),
      child: IconButton(
        iconSize: 35,
        onPressed: () {
          launchURL(url);
        },
        icon: logo,
          color: Colors.grey[50]
          )
   
    );
  }
}

class UserData extends StatelessWidget {
  final String label;
  UserData({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
    label,
    style: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: kPrimaryColor
    ));
  }
}

class Subheader extends StatelessWidget {
  final String label;
  Subheader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
    label,
    style: TextStyle(
      color: Colors.grey,
      letterSpacing: 3
    ),);
  }
}

void launchURL(url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
