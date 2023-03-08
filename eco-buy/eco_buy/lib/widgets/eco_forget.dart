import 'package:eco_buy/utils/eco_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EcoForgetButton extends StatelessWidget {
  String? title;
  VoidCallback? onTap;
  EcoForgetButton({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Text(
          "$title",
          style: EcoStyle.EcoBold.copyWith(
              fontSize: 15, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
