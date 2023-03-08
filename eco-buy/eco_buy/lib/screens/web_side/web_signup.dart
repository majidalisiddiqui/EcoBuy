import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/eco_style.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/eco_dailogue.dart';
import 'package:eco_buy/widgets/eco_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WebSignUpScreen extends StatefulWidget {
  WebSignUpScreen({super.key});

  @override
  State<WebSignUpScreen> createState() => _WebSignUpScreenState();
}

class _WebSignUpScreenState extends State<WebSignUpScreen> {
  TextEditingController userNameC = TextEditingController();

  TextEditingController emailC = TextEditingController();

  TextEditingController phoneC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  TextEditingController retypepasswordC = TextEditingController();
  bool? isLoading = false;
  User? currentUser = FirebaseAuth.instance.currentUser;

  webSignUp() async {
    var userName = userNameC.text.trim();
    var email = emailC.text.trim();
    var phone = phoneC.text.trim();
    var password = passwordC.text.trim();

    print("Websignupcall");
    setState(() {
      isLoading = true;
    });
    await FirebaseService.createAccount(email, password).then((value) {
      FirebaseService.userAccountData(
        email,
        userName,
        password,
        phone,
      );
    }).whenComplete(() {
      setState(() {
        isLoading = false;
        print("Account is here");
      });
      userNameC.clear();
      emailC.clear();
      phoneC.clear();
      passwordC.clear();
      retypepasswordC.clear();
    }).then((value) => EcoDialogue(
          title: "Account Created Succesfully",
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Sign Up Screen",
            style: EcoStyle.EcoBold.copyWith(),
          ),
          EcoTextField(
            controller: userNameC,
            hintText: "UserName",
          ),
          EcoTextField(
            controller: emailC,
            hintText: "Email",
          ),
          EcoTextField(
            controller: phoneC,
            hintText: "Phone",
          ),
          EcoTextField(
            controller: passwordC,
            hintText: "Password",
          ),
          EcoTextField(
            controller: retypepasswordC,
            hintText: "Retype Passwrod",
          ),
          EcoButton(
            isLoading: isLoading,
            onPress: () {
              webSignUp();
              print("pressed");
            },
            title: "Sign Up",
          )
        ],
      ),
    );
  }
}
