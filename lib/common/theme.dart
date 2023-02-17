import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColorLightpurple,
    background: backgroundPurple,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Colors.white,
    ),
  ),
);
