import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class VerificationPhone extends StatelessWidget {
  VerificationPhone({super.key, required this.verificationId});
  TextEditingController verificationCode = TextEditingController();
  String? verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App BAr")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(children: [
          TextFormField(
            controller: verificationCode,
            decoration: const InputDecoration(hintText: "Enter Phone Number"),
          ),
          ElevatedButton(
              onPressed: () {}, child: const Text("Verify Phone Number"))
        ]),
      ),
    );
  }
}
