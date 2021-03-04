import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primarySwatch: MaterialColor(4278781048, {
    50: Color(0xffe7e6fe),
    100: Color(0xffd0cefd),
    200: Color(0xffa09cfc),
    300: Color(0xff716bfa),
    400: Color(0xff423af8),
    500: Color(0xff1308f7),
    600: Color(0xff0f07c5),
    700: Color(0xff0b0594),
    800: Color(0xff070363),
    900: Color(0xff040231)
  }),
  brightness: Brightness.light,
  primaryColor: Color(0xff090478),
  buttonColor: Color(0xffd32f2f),
  bottomAppBarColor: Color(0xff090478),
  focusColor: Color(0xffd32f2f),
  iconTheme: IconThemeData(
    color: Color(0xdd000000),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: IconThemeData(
    color: Color(0xffffffff),
    opacity: 1,
    size: 24,
  ),
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xffd32f2f),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    alignedDropdown: false,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Color(0x8a000000),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      color: Color(0xffffffff),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Color(0xffffffff),
    unselectedLabelColor: Color(0xb2ffffff),
  ),
);
