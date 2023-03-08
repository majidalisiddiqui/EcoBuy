import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  List<String> name = ["Majid ", " Sajid ", "Wajid", "Kamran"];
  List<String> description = [
    "Majid is here ",
    " Sajid  is here  ",
    "Wajid iss here  ",
    "Kamran is here "
  ];

  List<bool> isexpand = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
          return isexpand[index]
              ? ListTile(
                  title: Text("${name[index]}"),
                  trailing: Text(description[index]),
                  onTap: () {
                    setState(() {
                      isexpand[index] = false;
                    });
                  },
                )
              : ListTile(
                  title: Text("${name[index]}"),
                  //trailing:  isexpand[index]  == true ? description ,
                  onTap: () {
                    setState(() {
                      int v = isexpand.indexOf(true);
                      if (v != -1) {
                        isexpand[v] = false;
                      }
                      isexpand[index] = true;
                    });
                  },
                );
        },
      ),
    );
  }
}
