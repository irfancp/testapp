import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'logIn.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/1280x1920.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height / 5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Log a fish spot'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width / 1.5, 80),
                    primary: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('View my sports'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width / 1.5, 80),
                    primary: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('View my Catches'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width / 1.5, 80),
                    primary: Colors.black54,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('My Gear'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width / 1.5, 80),
                    primary: Colors.black54,
                    // padding: EdgeInsets.all(30),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    auth.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LogIn()));
                  },
                  child: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(width / 1.5, 80),
                    primary: Colors.black54,
                    // padding: EdgeInsets.all(30),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
