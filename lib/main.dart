import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/services/preferences_manger.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
import 'core/constants/storage_key.dart';
import 'core/theme/light_theme.dart';
import 'features/tasks/controllers/tasks_controller.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await PreferencesManger().init();

  ThemeController().init();

  String? username = PreferencesManger().getString(StorageKey.username);

  FlutterNativeSplash.remove();

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifer,
      builder: (BuildContext context, themeMode, Widget? child) {
        return ChangeNotifierProvider<TasksController>(
          create: (_) => TasksController()..init(),
          child: MaterialApp(
            title: 'Tasky App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: username == null ? WelcomeScreen() : MainScreen(),
          ),
        );
      },
    );
  }
}