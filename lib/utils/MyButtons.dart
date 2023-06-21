import 'package:flutter/material.dart';
import 'package:todo_app/utils/Colors.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: MyColors.btColor,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
