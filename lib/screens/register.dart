import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'verify.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserCredential userCredential;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/1280x1920.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        "Registration",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(left: 5),
                            border: InputBorder.none,
                            labelText: "First Name",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(left: 5),
                            border: InputBorder.none,
                            labelText: "Last Name",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(left: 5),
                            border: InputBorder.none,
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
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
                            labelText: "Enter Password",
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: EdgeInsets.only(
                          top: 30, left: 30, right: 30, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re enter password';
                          }
                          if (value != password.text) {
                            return 'Please re enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.only(left: 5),
                            border: InputBorder.none,
                            labelText: "Re Enter Password",
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
                                  .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: password.text,
                                  )
                                  .then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => verify(),
                                      )));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                Fluttertoast.showToast(
                                    msg: "The password provided is too weak",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                Fluttertoast.showToast(
                                    msg:
                                        "The account already exists for that email",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                            print(userCredential);
                          }
                        },
                        child: Text("Proceed"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          padding: EdgeInsets.all(30),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
