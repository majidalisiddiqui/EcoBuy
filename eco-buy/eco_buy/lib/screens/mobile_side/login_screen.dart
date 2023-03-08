import 'package:eco_buy/screens/mobile_side/signup_phone.dart';
import 'package:eco_buy/screens/mobile_side/signup_screen.dart';
import 'package:eco_buy/utils/eco_style.dart';
import 'package:eco_buy/utils/utils.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/eco_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/firebase_services.dart';
import '../../widgets/eco_forget.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool formStateloading = false;
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
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateloading = true;
      });
      print("now Run here");
      String? accountstatus =
          await FirebaseService.signInAccount(emailC.text, passwC.text)
              .then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      }).onError((error, stackTrace) {
        Utils().toasMessage(error.toString());
      });
      if (accountstatus != null) {
        setState(() {
          ecoDailogue(accountstatus);
          formStateloading = false;
        });
      } else {
        // ignore: use_build_context_synchronously
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomeScreen(),
        //     ));
      }
      // .then((value) => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => LoginScreen(),
      //     )));
    }
  }

  bool ispassword = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "WellCome \n Please Login in ECO - BUy",
              textAlign: TextAlign.center,
              style: EcoStyle.EcoBold,
            ),
            Column(
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        EcoTextField(
                            controller: emailC,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "Please Enter the email";
                              }
                              return null;
                            },
                            icon: const Icon(Icons.email),
                            hintText: "Email..."),
                        EcoTextField(
                            controller: passwC,
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "Please Enter password";
                              }
                              return null;
                            },
                            hintText: "Password...",
                            isPassword: ispassword,
                            icon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ispassword = !ispassword;
                                    //  ispassword == true ? false : true;
                                    // ispassword:
                                    //!ispassword;
                                  });
                                },
                                icon: ispassword
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off))),
                        EcoButton(
                          title: "Login",
                          isLoginButton: true,
                          isLoading: formStateloading,
                          onPress: () {
                            submit();
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: EcoForgetButton(
                                title: "Forget Password?",
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            EcoButton(
                title: "CREATE A NEW ACCOUNT",
                isLoginButton: false,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ));
                }),
            EcoButton(
                title: "REGISTERED AS PHONE",
                isLoginButton: false,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPhone(),
                      ));
                })
          ],
        )),
      ),
    );
  }
}
