import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manger.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifer = ValueNotifier(
    ThemeMode.dark,
  );

  void init() {
    bool result = PreferencesManger().getBool("theme") ?? true;
    themeNotifer.value = result ? ThemeMode.dark : ThemeMode.light;
  }
    toggeleTheme() async {
      if (themeNotifer.value == ThemeMode.dark) {
        themeNotifer.value = ThemeMode.light;
        await PreferencesManger().setBool('theme', false);
      } else {
        themeNotifer.value = ThemeMode.dark;

    }
  }

  static bool isDark() => themeNotifer.value == ThemeMode.dark;




}
