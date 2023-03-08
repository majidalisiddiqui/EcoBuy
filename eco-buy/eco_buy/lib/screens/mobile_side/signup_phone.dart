import 'package:eco_buy/screens/mobile_side/verification_phone.dart';
import 'package:eco_buy/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignUpPhone extends StatelessWidget {
  SignUpPhone({super.key});

  TextEditingController phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  submit(BuildContext context) {
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumberController.text,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (e) {
          debugPrint(e.toString());
        },
        codeSent: ((verificationId, forceResendingToken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    VerificationPhone(verificationId: verificationId),
              ));
        }),
        codeAutoRetrievalTimeout: (e) {
          debugPrint(e.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App BAAR")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(children: [
          TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: "Enter Phone Number"),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Send Code")),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Back To Login "))
        ]),
      ),
    );
  }
}
