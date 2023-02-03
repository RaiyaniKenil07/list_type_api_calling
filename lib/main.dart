import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePage> {
  List users = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest API Call"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final id = user["id"];
          return ListTile(
            title: Text(id.toString()),
            subtitle: Text(user["category"].toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchPosts,
      ),
    );
  }

  void fetchPosts() async {
    final url = "https://dummyjson.com/products";
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    print("Expected responce");
    if (responce.statusCode == 200) {
      final json = jsonDecode(responce.body);
      setState(() {
        users = json["products"];
      });
    } else {
      print("Unexpected responce");
    }
  }
}
