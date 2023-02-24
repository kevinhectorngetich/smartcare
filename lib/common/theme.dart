import 'package:flutter/material.dart';
import 'package:smartcare/constants/constants.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: myprimaryColorLightpurple,
    background: mybackgroundPurple,
  ),

  // primaryColor: Colors.white,s
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Colors.white,
    ),
  ),
);

ButtonStyle kviewStats() {
  return ButtonStyle(
    // foregroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
    backgroundColor: MaterialStateProperty.all(Colors.white),
    padding: MaterialStateProperty.all(
      const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
    ),
  );
}

ButtonStyle kstartTimerButton() {
  return ButtonStyle(
    // foregroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
    backgroundColor: MaterialStateProperty.all(mypink),
    padding: MaterialStateProperty.all(
      const EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
    ),
  );
}
