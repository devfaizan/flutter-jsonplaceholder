import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsonplaceholder/gallery.dart';
import 'package:jsonplaceholder/homepage.dart';
import 'package:jsonplaceholder/models/users.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<User> userList = [];
  Future<List<User>> getUser() async {
    String url = "https://jsonplaceholder.typicode.com/users";
    final response = await http.get(
      Uri.parse(url),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(User.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text("Go to Home"),
              ),
              SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text("Go to Gallery"),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Column(
                              children: [
                                ReuseRow(
                                  title: "Name",
                                  value: snapshot.data![index].name.toString(),
                                ),
                                ReuseRow(
                                  title: "Username",
                                  value:
                                      snapshot.data![index].username.toString(),
                                ),
                                ReuseRow(
                                  title: "Address",
                                  value: snapshot.data![index].address!.street
                                          .toString() +
                                      "\n" +
                                      snapshot.data![index].address!.suite
                                          .toString() +
                                      "\n" +
                                      snapshot.data![index].address!.city
                                          .toString() +
                                      "\n" +
                                      snapshot.data![index].address!.zipcode
                                          .toString(),
                                ),
                                ReuseRow(
                                  title: "Geo",
                                  value: snapshot.data![index].address!.geo!.lat
                                          .toString() +
                                      "\n" +
                                      snapshot.data![index].address!.geo!.lng
                                          .toString(),
                                ),
                                ReuseRow(
                                  title: "Phone",
                                  value: snapshot.data![index].phone.toString(),
                                ),
                                ReuseRow(
                                  title: "Website",
                                  value:
                                      snapshot.data![index].website.toString(),
                                ),
                                ReuseRow(
                                  title: "Company",
                                  value: snapshot.data![index].company!.name
                                          .toString() +
                                      "\n" +
                                      snapshot.data![index].company!.catchPhrase
                                          .toString() +
                                      "\n" +
                                      snapshot.data![index].company!.bs
                                          .toString() +
                                      "\n",
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReuseRow extends StatelessWidget {
  String title, value;
  ReuseRow({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text("\n"),
        Text(value),
      ],
    );
  }
}
