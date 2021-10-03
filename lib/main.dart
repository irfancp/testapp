import 'dart:async';

import 'package:flutter/material.dart';
import 'package:log_a_catch/customers.dart';
import 'package:log_a_catch/provider/customer.dart';
import 'package:provider/provider.dart';

import 'model/customers.dart';
import 'customers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomerDetails>(
          create: (_) => CustomerDetails(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var customers;
  @override
  void initState() {
   Provider.of<CustomerDetails>(context, listen: false).addCustomer();  
    super.initState();
  }
  // context.read<attendanceDetailsProvider>().getAttendance(selectedDate_view);

  @override
  Widget build(BuildContext context) { 
      
                   Future.delayed(const Duration(seconds: 10), () {

    customers = context.read<CustomerDetails>().getCustomers();

});

                   Future.delayed(const Duration(seconds: 12), () {

    setState((){});

});
    return Scaffold(
      body: FutureBuilder(
        future: customers,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return Container(
              margin: EdgeInsets.all(50),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(left: 10),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data[index]["profile_image"]),
                                  fit: BoxFit.cover),
                            ),
                            // child:  Container(),

                            // alignment: Alignment.centerLeft,
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: 5, left: 10, bottom: 5),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data[index]["name"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   "${teachersData[index].lastname}",
                                // ),
                                Text(
                                  snapshot.data[index]["username"],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomersData(),
                            settings: RouteSettings(arguments: {
                              "name": snapshot.data[index]["name"],
                              "username": snapshot.data[index]["username"],
                              "email": snapshot.data[index]["email"],
                              "profile_image": snapshot.data[index]
                                  ["profile_image"],
                              "street": snapshot.data[index]["name"],
                              "suite": snapshot.data[index]["suite"],
                              "city": snapshot.data[index]["city"],
                              "website": snapshot.data[index]["website"],
                            }),
                          ));
                    },
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
  
    );
  }
}
