import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class verify extends StatefulWidget {
  verify({Key key}) : super(key: key);

  @override
  _verifyState createState() => _verifyState();
}

class _verifyState extends State<verify> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/1280x1920.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
                margin:
                    EdgeInsets.only(top: 50, left: 100, right: 100, bottom: 50),
                child: Image.asset("images/appLogo.png")),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "Verification Link has been sent to ${user.email} Please Verify your Email",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            // Container(
            //   width: width,
            //   height: 80,
            //   margin: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //   ),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         width: width / 4,
            //         child: TextFormField(
            //           decoration: InputDecoration(
            //               fillColor: Colors.white,
            //               contentPadding: EdgeInsets.only(left: 5),
            //               border: InputBorder.none,
            //               labelText: "Email",
            //               labelStyle: TextStyle(color: Colors.black)),
            //         ),
            //       ),
            //       Spacer(),
            //       Container(
            //         margin: EdgeInsets.only(top: 5,right: 10),
            //           width: width / 5,
            //           child: TextButton(
            //               onPressed: () {}, child: Text("send otp"))),

            //     ],
            //   ),
            // ),
            // Container(
            //   height: 80,
            //   margin: EdgeInsets.all(30),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //   ),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //         fillColor: Colors.white,
            //         contentPadding: EdgeInsets.only(left: 5),
            //         border: InputBorder.none,
            //         labelText: "Otp",
            //         labelStyle: TextStyle(color: Colors.black)),
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.all(20),
            //   child: ElevatedButton(
            //     onPressed: () {

            //     },
            //     child: Text("Verify"),
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.black54,
            //       shape: CircleBorder(side: BorderSide(color: Colors.white)),
            //       padding: EdgeInsets.all(30),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    ));
  }
}
