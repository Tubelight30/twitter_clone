//!not creating this textfield in common folder because this authfield is only used in login and signUp view
//!not outside the Auth Feature

import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/theme.dart';

class AuthField extends StatelessWidget {
  final TextEditingController
      controller; //asking for controller as if we call without the controller
  //all the textfields will have the same text in them
  final String hintText;
  const AuthField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Pallete.blueColor,
              width: 3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Pallete.greyColor,
            ),
          ),
          contentPadding: const EdgeInsets.all(22),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 18,
          )),
    );
  }
}
