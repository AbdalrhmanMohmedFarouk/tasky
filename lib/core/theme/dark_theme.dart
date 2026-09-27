import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFC6C6C6),
  ),
  scaffoldBackgroundColor: Color(0xFF181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181818),
    titleTextStyle: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.fontSize(20),
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
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
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF15B86C),
      foregroundColor: Color(0xFFFFFCFC),
      textStyle:
        TextStyle(fontSize: AppSizes.fontSize(14), fontWeight: FontWeight.w500),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style:TextButton.styleFrom(
      foregroundColor:Color(0xFFFFFCFC),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0XFF15B86C),
    foregroundColor: Color(0XFFFFFCFC),
    extendedTextStyle: TextStyle(fontSize: AppSizes.fontSize(14), fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSizes.fontSize(24),
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    displayMedium: TextStyle(
      fontSize: AppSizes.fontSize(28),
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFFFF),
    ),
    titleSmall: TextStyle(
      fontSize: AppSizes.fontSize(14),
      fontWeight: FontWeight.w400,
      color: Color(0XFFC6C6C6),
    ),
    titleMedium: TextStyle(
      fontSize: AppSizes.fontSize(16),
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    titleLarge: TextStyle(
      fontSize: AppSizes.fontSize(16),
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      color: Color(0xFF15B86C),
      decorationColor: Color(0XFFA0A0A0),
      overflow: TextOverflow.ellipsis,
    ),
    displayLarge: TextStyle(
      fontSize: AppSizes.fontSize(32),
      fontWeight: FontWeight.w400,
      color: Color(0XFFFFFCFC),
    ),
    labelSmall: TextStyle(
      fontSize: AppSizes.fontSize(20),
      fontWeight: FontWeight.w400,
      color: Color(0XFFFFFCFC),
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: AppSizes.fontSize(16)),
    labelLarge: TextStyle(color: Colors.white, fontSize: AppSizes.fontSize(24)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0XFF6D6D6D)),
    filled: true,
    fillColor: Color(0XFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular( AppSizes.radius(16)),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular( AppSizes.radius(16)),
      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular( AppSizes.radius(4)),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: AppSizes.fontSize(16),
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.black,
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0XFFC6C6C6),
    selectedItemColor: Color(0XFF15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0XFF15B86C), width: 1),
      borderRadius: BorderRadius.circular( AppSizes.radius(16)),
    ),
    elevation: 2,
    shadowColor: Color(0XFF15B86C),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(fontSize: AppSizes.fontSize(20), fontWeight: FontWeight.w400),
    ),
  ),
);
