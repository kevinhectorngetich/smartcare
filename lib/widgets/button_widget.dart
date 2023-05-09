import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onClicked,
    this.foregroundColor = mypink,
    this.backgroundColor = Colors.white,
  });
  final String text;
  final Color foregroundColor;
  final Color backgroundColor;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClicked,
      // style: kstartTimerButton(),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 13.0,
          // color: mypink,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// copyright KevinHector
