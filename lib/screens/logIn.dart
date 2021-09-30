import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class LogIn extends StatefulWidget {
  LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  final auth = FirebaseAuth.instance;
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
              height: 80,
              margin: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 5),
                    border: InputBorder.none,
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              height: 80,
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 5),
                    border: InputBorder.none,
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: ()async {
                  print(emailController.text);
                  print(password.text);
                  try {
                    await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: password.text)
                        .then((value) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Home())));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      Fluttertoast.showToast(
                          msg: "No user found for that email",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      Fluttertoast.showToast(
                          msg: "Wrong password provided for that user.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      print('Wrong password provided for that user.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black54,
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  padding: EdgeInsets.all(30),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
