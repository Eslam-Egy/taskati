import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskati/core/constants/app_font.dart';

import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

abstract class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: AppFonts.lexendDeca,
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          onSurface: AppColors.blackColor,
          seedColor: AppColors.primaryColor,
        ),
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: TextStyles.title.copyWith(
            color: AppColors.blackColor,
            fontFamily: AppFonts.lexendDeca,
          ),
          foregroundColor: AppColors.blackColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.backgroundColor,
          filled: true,
        ),
      );

  //dark mode
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        fontFamily: AppFonts.lexendDeca,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryColor,
          surface: Color(0xFF1E1E1E),
          onSurface: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: TextStyles.title.copyWith(
            color: Colors.white,
            fontFamily: AppFonts.lexendDeca,
          ),
          foregroundColor: Colors.white,
        ),
        tabBarTheme: TabBarThemeData(
          dividerColor: Colors.transparent,
          labelStyle: TextStyles.caption1.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          unselectedLabelStyle: TextStyles.caption1.copyWith(
            color: Colors.grey,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: Colors.grey,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          hintStyle: TextStyles.caption1.copyWith(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
        ),
        cardColor: const Color(0xFF1E1E1E),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      );
}
