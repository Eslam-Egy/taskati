import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/servicer/hive_helper.dart';
import 'package:taskati/core/servicer/shared_pref.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/themes.dart';
import 'package:taskati/features/splash/splash_screen.dart';
import 'package:taskati/hive/hive_adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Shared Pref
  await SharedPrefHelper.init();

  /// Hive
  await Hive.initFlutter();

  /// Register Adapter
  Hive.registerAdapter(TaskModelAdapter());
  await HiveHelper.init();

  /// Open Box
  await Hive.openBox<TaskModel>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      themeMode =
          themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeMode, // 🔥 أهم سطر

      builder: (context, child) {
        return SafeArea(
          top: false,
          bottom: Platform.isAndroid,
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF121212)
                      : AppColors.backgroundColor,
                ),
                Image.asset(
                  "assets/images/Group 1.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                child!,
              ],
            ),
          ),
        );
      },

      home: SplashScreen(
        toggleTheme: toggleTheme, 
      ),
    );
  }
}
