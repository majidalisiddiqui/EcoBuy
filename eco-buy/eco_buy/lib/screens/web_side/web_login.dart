import 'package:eco_buy/screens/web_side/web_main.dart';
import 'package:eco_buy/screens/web_side/web_signup.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/eco_style.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/eco_dailogue.dart';
import 'package:eco_buy/widgets/eco_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/eco_forget.dart';

// ignore: must_be_immutable
class WebLoginSCreen extends StatefulWidget {
  static const String id = "weblogin";

  const WebLoginSCreen({super.key});

  @override
  State<WebLoginSCreen> createState() => _WebLoginSCreenState();
}

class _WebLoginSCreenState extends State<WebLoginSCreen> {
  TextEditingController userNameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool formStateLoading = false;
  webSubmit() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      dynamic firebaseUser =
          FirebaseService.webAdminSignIn(userNameC.text, passwordC.text);
      if (firebaseUser != null) {
        setState(() {
          formStateLoading = false;
          Navigator.pushReplacementNamed(context, WebMainScreen.id);
        });
      }
    }
  }

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      await FirebaseService.adminSignIn(userNameC.text).then((value) async {
        if (value['user'] == userNameC.text &&
            value['password'] == passwordC.text) {
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            if (user != null) {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => WebMainScreen(),
              //     ));
              Navigator.pushReplacementNamed(context, WebMainScreen.id);
            }
          } catch (e) {
            setState(() {
              formStateLoading = false;
            });
            showDialog(
                context: context,
                builder: (_) {
                  return EcoDialogue(
                    title: e.toString(),
                  );
                });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 5)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "WELLCOME ADMIN",
                    style: EcoStyle.EcoBold,
                  ),
                  const Text(
                    "LOGIN TO YOUR ACCOUNT",
                    style: EcoStyle.EcoBold,
                  ),
                  EcoTextField(
                    hintText: "UserName",
                    controller: userNameC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Please Enter Username";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    hintText: "Password",
                    controller: passwordC,
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Please enter Password";
                      }
                      return null;
                    },
                  ),
                  EcoButton(
                    onPress: () {
                      //  submit(context);
                      webSubmit();
                    },
                    isLoading: formStateLoading,
                    title: "LOGIN",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: EcoForgetButton(title: "Forget Password?"),
                      ),
                    ],
                  ),
                  EcoButton(
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebSignUpScreen(),
                          ));
                    },
                    isLoading: formStateLoading,
                    title: "Create an Account",
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
