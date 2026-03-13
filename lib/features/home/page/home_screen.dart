import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:taskati/core/function/navigation.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/features/home/widgets/daily__progress.dart';
import 'package:taskati/features/home/widgets/home_date_picer.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/task_builder.dart';
import 'package:taskati/features/task/page/add_tesk_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                const HomeHeader(),
                const Gap(24),
                const DailyProgress(),
                const Gap(24),
                const HomeDatePicer(),
                const Gap(32),
                Expanded(child: TaskBuilder()),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pushto(context, AddTaskScreen());
          },
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add, color: AppColors.backgroundColor),
        ),
      ),
    );
  }
}
