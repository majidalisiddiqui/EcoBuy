import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String? name;
  String? profilePhoto;
  String? email;
  String? uid;
  myUser(
      {required this.name,
      required this.email,
      required this.profilePhoto,
      required this.uid});
//UI to Map Firebase
  //App  ==>>> Firebase (Map) in json

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profilePic": profilePhoto,
      "email": email,
      "uid": uid
    };
  }

  //From Map to UI
  //Firebase(Map) ==>>  App (Uuser)
  static myUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return myUser(
        name: snapshot['name'],
        email: snapshot['email'],
        profilePhoto: snapshot['profilePic'],
        uid: snapshot['uid']);
  }
}
