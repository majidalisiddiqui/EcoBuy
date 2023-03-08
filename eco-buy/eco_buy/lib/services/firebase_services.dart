import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/screens/mobile_side/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FirebaseService {
  static Future webAdminSignIn(String email, String password) async {
    try {
      (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      Get.to(const LoginScreen());
    } on FirebaseAuthException catch (e) {
      print("Error $e");
    }
  }

  //admin
  static Future<DocumentSnapshot> adminSignIn(id) async {
    var result = FirebaseFirestore.instance.collection("admin").doc(id).get();
    //FirebaseService.signOut();
    return result;
  }

//create user data
  static Future userAccountData(
    String email,
    String userName,
    String password,
    String phone,
  ) async {
    User? userid = FirebaseAuth.instance.currentUser;
    try {
      FirebaseFirestore.instance.collection("admin").doc(userid!.uid).set({
        "username": userName,
        "email": email,
        "password": password,
        "phone": phone,
        "creaetdAt": DateTime.now(),
        "userid": userid.uid,
      }).then((value) => {print("Account Successfully here in Firebase")});
    } on FirebaseAuthException catch (e) {
      print("Erroe $e");
    }
  }

//create account user
  static Future<String?> createAccount(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Email Already in use";
      } else if (e.code == "weak-password") {
        return " Password too weak";
      }
      print(e.toString());
      return e.message;
    }
  }

//SignOut User
  static Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      //  Get.to(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      print("Sign out Erro $e");
    }
  }

//Signin Users
  static Future<String?> signInAccount(String email, String password) async {
    try {
      print("Firebase Sign in email and Password verification ");
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
