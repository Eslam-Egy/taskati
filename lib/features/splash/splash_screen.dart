import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:taskati/core/constants/app_assets.dart';
import 'package:taskati/core/function/navigation.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/home/page/home_screen.dart';
import 'package:taskati/features/splash/upload/page/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const SplashScreen({super.key, required this.toggleTheme});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

Future<void> checkUser() async {
  final prefs = await SharedPreferences.getInstance();

  String? name = prefs.getString('name');
  String? image = prefs.getString('image');

  await Future.delayed(const Duration(seconds: 4));

  if (!mounted) return;

  if (name != null && image != null) {
    pushReplacment(
      context,
      HomeScreen(toggleTheme: widget.toggleTheme),
    );
  } else {
    pushReplacment(context, const UploadScreen());
  }
} // ✅ دي كانت ناقصة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(AppAssets.logoJson),
            Gap(12),
            Text(
              "Taskati",
              style: TextStyles.headline.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            Gap(18),
            Text(
              "It’s time to get organized",
              style: TextStyles.caption1.copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
