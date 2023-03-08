import 'package:eco_buy/screens/mobile_side/login_screen.dart';
import 'package:eco_buy/utils/eco_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

// ignore: must_be_immutable
class LandingScreen extends StatelessWidget {
  // const LandingScreen({super.key});
  Future<FirebaseApp> initilaze = Firebase.initializeApp();

  LandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initilaze,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot) {
              if (streamsnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("${streamsnapshot.error}"),
                  ),
                );
              }
              if (streamsnapshot.connectionState == ConnectionState.active) {
                User? user = streamsnapshot.data;
                if (user == null) {
                  return const LoginScreen();
                } else {
                  return HomeScreen();
                }
              }
              return Scaffold(
                body: Column(
                  children: const [
                    Center(
                      child: Text(
                        "Checking authentication AP",
                        style: EcoStyle.EcoBold,
                      ),
                    ),
                    CircularProgressIndicator()
                  ],
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Column(
            children: const [
              Center(
                child: Text("INTIlAZE APP"),
              ),
              CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }
}
