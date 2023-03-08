import 'package:eco_buy/widgets/eco_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // List<Map> student = [];
  final db = FirebaseDatabase.instance.ref('Post');
  @override
  void initState() {
    super.initState();
    //  print(db.child('Name').onValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Expanded(
          //     child: StreamBuilder(
          //   stream: db.onValue,
          //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //     return ListView.builder(
          //       itemCount: snapshot.data!.snapshot.children.length,
          //       itemBuilder: (context, index) {
          //         return ListTile(
          //           title: Text(index.toString()),
          //         );
          //       },
          //     );
          //   },
          // )),
          Expanded(
            child: FirebaseAnimatedList(
              query: db,
              itemBuilder: (context, DataSnapshot snapshot, animation, index) {
                Map student = snapshot.value as Map;
                debugPrint(student['Name']);
                debugPrint(snapshot.key);
                debugPrint(snapshot.value.toString());

                print(snapshot.child('').child('Name').toString());

                print(snapshot.child('title').toString());
                debugPrint(student[index]);

                //student['key'] = snapshot.key;

                return ListTile(
                    title: Text(snapshot.child('Name').value.toString()));
                // title: Text('Name'));
              },
            ),
          ),
          EcoButton(
            title: "Back",
            onPress: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
