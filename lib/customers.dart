import 'package:flutter/material.dart';




class CustomersData extends StatefulWidget {
  CustomersData({Key key}) : super(key: key);

  @override
  _CustomersDataState createState() => _CustomersDataState();
}

class _CustomersDataState extends State<CustomersData> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
        Map data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SingleChildScrollView(
            child: Container(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 25, right: 25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ]),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: height / 2.5,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      image: DecorationImage(
                          image: NetworkImage(data["profile_image"]),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      "${data["name"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        "${data["username"]}",
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        "${data["email"]}",
                      )),
                        Container(
                      margin: EdgeInsets.only(left: 15, top: 5),
                      child: Text(
                        "${data["website"]}",
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 15, top: 15),
                      child: Text(
                        "${data["street"]} ${data["suite"]} ${data["city"]}",
                      )),
            
               
                   
                ],
              ),
            ),
          ),
        ))
      
    );
  }
}