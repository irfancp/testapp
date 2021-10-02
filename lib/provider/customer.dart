import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:log_a_catch/model/customers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

class CustomerDetails with ChangeNotifier {
  bool done = false;
  List<Data> customer = [];

  addCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int dbcreated = prefs.getInt('db') ?? 0;
    if (dbcreated == 0) {
      var databasesPath = await getDatabasesPath();

      final response = await http.get(
        'http://www.mocky.io/v2/5d565297300000680030a986',
      );
      if (response.statusCode == 200) {
        Iterable list = jsonDecode(response.body);
        for (var l in list) {
          customer.add(Data.fromJson(l));
        }
      } else {
        print(response.body);
        throw Exception('Failed to load');
      }
      print("isdbCreated$customer");
      try {
        String path = join(databasesPath, 'demo.db');
        Database database = await openDatabase(path, version: 3,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE Customers (id INTEGER PRIMARY KEY, name TEXT,username TEXT,email TEXT,profile_image TEXT,street TEXT,suite TEXT,city TEXT ,zipcode TEXT,phone TEXT,website TEXT,company_name TEXT)');
          // ignore: missing_return
        }).then((value) async {
          var db = await openDatabase('demo.db');
          // Database database = await openDatabase(databasesPath, version: 1);
          for (var c in customer) {
            await db.transaction((txn) async {
              int id1 = await txn.rawInsert(
                  "INSERT INTO Customers VALUES('${c.id}','${c.name}','${c.username}','${c.email}','${c.profileImage}','${c.address.street}','${c.address.suite}','${c.address.city}','${c.address.zipcode}','${c.phone}','${c.website}','${c.company.name}')");
              print('inserted1: $id1');
            });
            prefs.setInt('db', 1);
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  getCustomers() {
    var data;
    getData() async {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'demo.db');

      // var databasesPath = await getDatabasesPath();
      var db = await openDatabase('demo.db');
      // Get the records
      List<Map> list = await db.rawQuery('SELECT * FROM Customers');
// List<Map> expectedList = [
//   {'name': 'updated name', 'id': 1, 'value': 9876, 'num': 456.789},
//   {'name': 'another name', 'id': 2, 'value': 12345678, 'num': 3.1416}
// ];

      return list;
    }

    data = getData();
    done = true;
    print("hii$data");
    return data;

// print(expectedList);
// assert(const DeepCollectionEquality().equals(list, expectedList));
  }
}
