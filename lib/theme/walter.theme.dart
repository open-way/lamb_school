import 'package:flutter/material.dart';

final ThemeData walterTheme = new ThemeData(
    primaryColor: Color(0xFF1973FF),
    //dialog button
    accentColor: Color(0xFF003366),
    //all background color
    canvasColor: Color(0xFFF1F2F2),
    //backgroundColor: Color(0xFFB9BABA),
    textTheme: TextTheme(
        //ListTitle(title)
        subtitle: TextStyle(color: Colors.black87),
        body2: TextStyle(color: Colors.white)
        // subtitle1: TextStyle(color: Colors.black87),
        // //Menu texto
        // bodyText1: TextStyle(color: Colors.black87),
        // //Calentar title, widget Text()
        // bodyText2: TextStyle(color: Colors.black54),
        ),
    appBarTheme: AppBarTheme(
      //AppBar
      color: Color(0xFF1973FF),
      //icon
      actionsIconTheme: IconThemeData(color: Colors.white),
      //textTheme: TextTheme(title: TextStyle(color: Colors.white,))
      //iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
    ),
    dividerTheme: DividerThemeData(color: Color(0xFFB8DDFF), thickness: 2),
    //tabBarTheme: TabBarTheme(labelColor: Color(0xFF003366)),
    buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary, buttonColor: Color(0xFF003366)),
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    primaryColorBrightness: Brightness.dark,
    accentColorBrightness: Brightness.dark,
    backgroundColor: Color(0xFFF1F2F2),
    inputDecorationTheme: InputDecorationTheme(fillColor: Color(0xFFB9BABA)));
