import 'package:flutter/material.dart';

import '../utils/eco_style.dart';

class HomeCards extends StatelessWidget {
  final String? title;
  HomeCards({
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Colors.blueAccent.withOpacity(0.8),
              Colors.redAccent.withOpacity(0.8),
            ])),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            title ?? "TITLE",
            style: EcoStyle.EcoBold.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
