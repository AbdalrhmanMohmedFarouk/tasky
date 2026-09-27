import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF3A4640),
  ),
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
    centerTitle: true,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 3;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Colors.black),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0XFF15B86C),
    foregroundColor: Color(0XFFFFFCFC),
    extendedTextStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSizes.fontSize(24),
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    displayMedium: TextStyle(
      fontSize: AppSizes.fontSize(28),
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    displayLarge: TextStyle(
      fontFamily: "PlusJakartaSans",
      fontSize: AppSizes.fontSize(32),
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    titleSmall: TextStyle(
      fontFamily: "Poppins",
      fontSize: AppSizes.fontSize(14),
      fontWeight: FontWeight.w400,
      color: Color(0xFF3A4640),
    ),
    titleMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: AppSizes.fontSize(16),
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    titleLarge: TextStyle(
      fontSize: AppSizes.fontSize(16),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      color: Color(0xFF6A6A6A),
      decorationColor: Color(0XFF49454F),
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      fontFamily: "Poppins",
      fontSize: AppSizes.fontSize(20),
      fontWeight: FontWeight.w400,
      color: Color(0XFF161F1B),
    ),
    labelLarge: TextStyle(color: Colors.black, fontSize: 24),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    enabledBorder: InputBorder.none,
    focusColor: Color(0xFFD1DAD6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.white,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0XFF3A4640),
    selectedItemColor: Color(0XFF14A662),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0XFF15B86C), width: 1),
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 2,
    shadowColor: Color(0XFF15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
    ),
  ),
);
