import 'package:eco_buy/services/auth/auth_controller.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/eco_style.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/eco_textfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController usernameC = TextEditingController();

  TextEditingController passwC = TextEditingController();
  TextEditingController retypepassC = TextEditingController();
  bool ispassword = true;
  bool isretypepassword = true;
  FocusNode? passwordfocus;
  FocusNode? retypepasswordfocus;
  bool formStateloading = false;
  final formkey = GlobalKey<FormState>();
  Future<void> ecoDailogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                title: "Close",
                onPress: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      if (passwC.text == retypepassC.text) {
        setState(() {
          formStateloading = true;
        });
        String? accountstatus =
            await FirebaseService.createAccount(emailC.text, passwC.text);
        if (accountstatus != null) {
          setState(() {
            ecoDailogue(accountstatus);
            formStateloading = false;
          });
        } else {
          Navigator.pop(context);
        }
        // .then((value) => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => LoginScreen(),
        //     )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Wellcome \n CREATE AN ACCOUNT FIRST ",
                textAlign: TextAlign.center,
                style: EcoStyle.EcoBold,
              ),
              Column(
                children: [
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: IconButton(
                                      onPressed: () {
                                        AuthController.instance.pickImage();
                                      },
                                      icon: Icon(Icons.edit)),
                                ),
                              )
                            ],
                          ),
                          EcoTextField(
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "Pass Shold Not be Blank";
                              }
                              return null;
                            },
                            controller: usernameC,
                            hintText: "User Name.",
                          ),
                          EcoTextField(
                              validate: (v) {
                                if (v!.isEmpty ||
                                    !v.contains("@") ||
                                    !v.contains(".com")) {
                                  return "Email is not in formated";
                                }
                                return null;
                              },
                              inputAction: TextInputAction.next,
                              icon: const Icon(Icons.email),
                              controller: emailC,
                              hintText: "Email...,"),
                          EcoTextField(
                              validate: (v) {
                                if (v!.isEmpty) {
                                  return "Pass Shold Not be Blank";
                                }
                                return null;
                              },
                              inputAction: TextInputAction.next,
                              focusNode: passwordfocus,
                              controller: passwC,
                              isPassword: ispassword,
                              icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      ispassword = !ispassword;
                                      //isPassword:
                                      //!ispassword;
                                    });
                                  },
                                  icon: ispassword
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              hintText: "Password..."),
                          EcoTextField(
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "Pass Shold Not be Blank";
                              }
                              return null;
                            },
                            focusNode: retypepasswordfocus,
                            controller: retypepassC,
                            isPassword: isretypepassword,
                            hintText: "Retype Password...",
                            icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isretypepassword = !isretypepassword;
                                  });
                                },
                                icon: isretypepassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                          ),
                          EcoButton(
                            title: "SIGNUP",
                            isLoginButton: true,
                            isLoading: formStateloading,
                            onPress: () {
                              // AuthController.instance.signUp(
                              //     usernameC.text,
                              //     emailC.text,
                              //     passwC.text,
                              //     AuthController.instance.proImg);
                              submit();
                            },
                          ),
                        ],
                      )),
                ],
              ),
              EcoButton(
                title: "BACK TO LOGIN",
                isLoginButton: false,
                onPress: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
