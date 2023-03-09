import 'package:flutter/material.dart';

class ApiCrud extends StatefulWidget {
  const ApiCrud({super.key});

  @override
  State<ApiCrud> createState() => _ApiCrudState();
}

class _ApiCrudState extends State<ApiCrud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Record"),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter the Name"),
                ),
              )),
          Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter the Email"),
                ),
              )),
          Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter the Password"),
                ),
              )),
          ElevatedButton(onPressed: () {}, child: Text("Sign up"))
        ],
      ),
    );
  }
}
