import 'package:flutter/material.dart';

class MyTheme {
  static Color redColor = const Color(0xffEC4B4B);
  static Color primaryColor = const Color(0xff5D9CEC);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color greyColor = const Color(0xffA9A9A9);
  static Color greenColor = const Color(0xff61E757);
  static Color backGroundLightColor = const Color(0xffDFECDB);
  static Color blackLightColor = const Color(0xff383838);
  static Color backgroundDarkColor = const Color(0xff060E1E);
  static Color blackDarkColor = const Color(0xff141922);
  static Color blackColor = const Color(0xFF000000);

  static ThemeData lightTheme = ThemeData(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: greyColor,
        selectedItemColor: primaryColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backGroundLightColor,
      appBarTheme: AppBarTheme(elevation: 0, backgroundColor: primaryColor),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: whiteColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 4, color: whiteColor),
          )),
      bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(color: primaryColor, width: 4))));
  static ThemeData darkTheme = ThemeData(
      canvasColor: blackDarkColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 5,
        shape: CircleBorder(
            side: BorderSide(width: 3, color: MyTheme.blackLightColor)),
      ),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundDarkColor,
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: blackLightColor,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              side: BorderSide(width: 4, color: primaryColor))),
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          elevation: 0,
          titleTextStyle: TextStyle(
              fontFamily: "Poppins-Regular",
              color: backgroundDarkColor,
              fontSize: 22,
              fontWeight: FontWeight.bold)),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontFamily: "Poppins-Regular",
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          bodySmall: TextStyle(
              fontFamily: "Roboto",
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: primaryColor)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: primaryColor,
          unselectedItemColor: whiteColor,
          unselectedLabelStyle: TextStyle(
            color: whiteColor,
          ),
          unselectedIconTheme: IconThemeData(color: whiteColor, size: 35),
          selectedIconTheme: IconThemeData(color: primaryColor, size: 35)));
}
