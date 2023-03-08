import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/eco_textfield.dart';
import 'package:flutter/material.dart';

class WebForgetPassword extends StatelessWidget {
  TextEditingController emailC = TextEditingController();
  WebForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        EcoTextField(
          controller: emailC,
          hintText: "Email",
        ),
        EcoButton(
          title: "Send an email",
        )
      ]),
    );
  }
}
