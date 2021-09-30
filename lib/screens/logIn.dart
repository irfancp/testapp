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
    final _formKey = GlobalKey<FormState>();
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  margin:
                      EdgeInsets.only(top: height/20, left: 100, right: 100, bottom: height/10),
                  child: Image.asset("images/appLogo.png")),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: height/20, left: 30, right: 30, bottom: height/30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
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
                height: 60,
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
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
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: password.text)
                            .then((value) => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => Home())));
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
      ),
    ));
  }
}
