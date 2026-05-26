import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manger.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
import 'core/constans/storage_key.dart';
import 'core/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManger().init();

ThemeController().init();


  String? username = PreferencesManger().getString(StorageKey.username);

  // final pref = await SharedPreferences.getInstance();
  // String? username = pref.getString('username');
  // print("username is $username");
  // themeNotifer.value = ThemeMode.dark;

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable:  ThemeController.themeNotifer,
      builder: (BuildContext context, themeMode, Widget? child) {
        return MaterialApp(
          title: 'Tasky App',
          // debugShowCheckedModeBanner:false ,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,

          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
