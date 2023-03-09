import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart  ' as http;

class HomeApiScreen extends StatefulWidget {
  const HomeApiScreen({super.key});

  @override
  State<HomeApiScreen> createState() => _HomeApiScreenState();
}

class _HomeApiScreenState extends State<HomeApiScreen> {
  Map<String, dynamic>? dataMap;
  Map<String, dynamic>? DonedataMap;

  String url = 'https://reqres.in/api/users/2';
  Future hitApi() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        dataMap = jsonDecode(response.body);
        DonedataMap = dataMap!['data'];
        print(DonedataMap);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hitApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Hellow"),
          Text(DonedataMap!['email'].toString()),
        ],
      ),
    );
  }
}
