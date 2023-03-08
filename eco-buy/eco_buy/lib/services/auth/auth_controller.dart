import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_buy/models/getx_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? proImg;

//User Register
  void signUp(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        //uploading Picture
        String downloadUrl = await _uploadProPic(image);
        myUser user = new myUser(
            name: username,
            email: email,
            profilePhoto: downloadUrl,
            uid: credential.user!.uid);

        // uploading data here
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
            " Error Creating Account ", " PLease Enter all required field");
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error ", e.toString());
    }
  }

//Upload Imaage
  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }

//PickImage From Phone
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      final img = File(image!.path);
      proImg = img;
    }
  }
  //To login in screen

  login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error Logging In", "Please Enter email and Password");
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error Loggin iN ", e.toString());
    }
  }

  //User State Persistence
  User? _user;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //Rx is checking variable vavlue or chaning or not
    _user = Rx<User?>(FirebaseAuth.instance.currentUser) as User?;
  }
}
