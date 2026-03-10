import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/features/splash/splash_screen.dart';

void main() {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                  color: AppColors.backgroundColor,
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
      home: const SplashScreen(),
    );
  }
}
