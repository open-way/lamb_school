import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.blueGrey,
    accentColor: Color(0xff40bf7a),
    textTheme: TextTheme(
      subtitle: TextStyle(color: Color(0xff40bf7a)),
      // headline6: TextStyle(color: Color(0xff40bf7a)),
      // subtitle2: TextStyle(color: Colors.white),
      // subtitle1: TextStyle(color: Color(0xff40bf7a)),
    ),
    appBarTheme: AppBarTheme(color: Color(0xff1f655d)));
