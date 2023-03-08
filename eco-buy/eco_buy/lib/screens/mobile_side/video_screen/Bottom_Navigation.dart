import 'package:eco_buy/screens/mobile_side/forget_password.dart';
import 'package:eco_buy/screens/mobile_side/home_screen.dart';
import 'package:eco_buy/screens/mobile_side/login_screen.dart';
import 'package:eco_buy/screens/mobile_side/signup_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BottomNavigatorBar extends StatefulWidget {
  BottomNavigatorBar({super.key});

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int pageIdx = 0;
  List screens = [
    HomeScreen(),
    ForgetPassword(),
    SignUpPhone(),
    SignUpPhone(),
    LoginScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIK TOk"),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIdx,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: (value) {
            setState(() {
              print(value);
              pageIdx = value;
              print(pageIdx);
            });
          },
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home,
                  size: 25,
                )),
            BottomNavigationBarItem(
                label: "Search", icon: Icon(Icons.search, size: 25)),
            BottomNavigationBarItem(
                label: "", icon: Icon(Icons.message, size: 25)),
            BottomNavigationBarItem(
                label: "Message", icon: Icon(Icons.message, size: 25)),
            BottomNavigationBarItem(
                label: "Profile", icon: Icon(Icons.person, size: 25)),
          ]),
      body: screens[pageIdx],
    );
  }
}
