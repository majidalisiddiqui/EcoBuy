import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EcoTextField extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  bool? isPassword;
  Widget? icon;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  int? maxLines;

  EcoTextField(
      {this.hintText,
      this.controller,
      this.validate,
      this.isPassword = false,
      this.icon,
      this.focusNode,
      this.inputAction,
      this.maxLines,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
      ),
      child: TextFormField(
        // minLines: 1,
        //maxLines: maxLines == 1 ? 1 : maxLines,
        focusNode: focusNode,
        textInputAction: inputAction,
        obscureText: isPassword! == false ? false : isPassword!,
        validator: validate,
        controller: controller,
        decoration: InputDecoration(

            //   hintText: hintText ?? 'hint text...',
            suffixIcon: icon,
            labelText: hintText,
            contentPadding: const EdgeInsets.all(20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
