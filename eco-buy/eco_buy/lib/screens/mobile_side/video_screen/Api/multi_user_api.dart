import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart  ' as http;

class MultiUserApi extends StatefulWidget {
  const MultiUserApi({super.key});

  @override
  State<MultiUserApi> createState() => _MultiUserApiState();
}

class _MultiUserApiState extends State<MultiUserApi> {
  Map<String, dynamic>? dataMap;
  Map<String, dynamic>? DonedataMap;
  List<dynamic>? doneListData;

  String url = 'https://reqres.in/api/users?page=2';

  Future hitApi() async {
    try {
      http.Response response;
      response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          dataMap = jsonDecode(response.body);
          doneListData = dataMap!['data'];
          print(doneListData);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hitApi();
    print(doneListData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: doneListData!.length,
      itemBuilder: (context, index) {
        return doneListData == null
            ? CircularProgressIndicator()
            : ListTile(
                title: Text(doneListData![index]['first_name'].toString()),
              );
      },
    ));
  }
}
