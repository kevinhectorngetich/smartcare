import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';
import 'package:smartcare/constants/text_style.dart';

InputDecoration tFieldInputDecoration(
    {inputlabeltext, inputhinttext, suffixIcon}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelText: inputlabeltext,
    labelStyle: kCaptionStyle,
    hintText: inputhinttext,
    suffixIcon: suffixIcon,
    hintStyle: kPlaceholderStyle,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white30, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Colors.white30, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      gapPadding: 0.0,
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: mypink, width: 2.0),
    ),
  );
}
