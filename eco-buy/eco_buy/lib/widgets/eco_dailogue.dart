import 'package:flutter/material.dart';

import 'eco_button.dart';

class EcoDialogue extends StatelessWidget {
  final String? title;
  const EcoDialogue({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("$title"),
      actions: [
        EcoButton(
          title: "Close",
          onPress: () => Navigator.pop(context),
        )
      ],
    );
  }
}
