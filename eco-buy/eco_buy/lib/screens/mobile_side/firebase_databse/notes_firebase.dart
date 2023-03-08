import 'package:eco_buy/screens/mobile_side/firebase_databse/post_screen.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/eco_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NotesFirebase extends StatelessWidget {
  NotesFirebase({
    super.key,
  });

  TextEditingController postController = TextEditingController();

  DatabaseReference? databaseRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        EcoTextField(
          controller: postController,
        ),
        EcoButton(
          onPress: () async {
            Map<String, dynamic> student = {
              "title ": postController.text,
            };
            try {
              databaseRef = await FirebaseDatabase.instance
                  .ref('Post')
                  .child(DateTime.now().microsecondsSinceEpoch.toString());
              await databaseRef!.set(student);
            } catch (e) {
              debugPrint(e.toString());
            }
          },
          title: "Add Data",
        ),
        EcoButton(
          title: "Post Screen",
          onPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostScreen(),
                ));
          },
        )
      ]),
    );
  }
}
