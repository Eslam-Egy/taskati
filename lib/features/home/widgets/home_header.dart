import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskati/core/servicer/shared_pref.dart';
import 'package:taskati/core/styles/text_styles.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String name = "";
  String path = "";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    name = await SharedPrefHelper.getName() ?? "";
    path = await SharedPrefHelper.getImage() ?? "";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: path.isEmpty
              ? Image.asset("assets/images/user 1.png", height: 50, width: 50)
              : Image.file(File(path), height: 50, width: 50),
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello!", style: TextStyles.caption1),
            const Gap(4),
            Text(name, style: TextStyles.title),
          ],
        ),
      ],
    );
  }
}
