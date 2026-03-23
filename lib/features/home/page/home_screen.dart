import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:taskati/core/function/navigation.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/features/home/widgets/daily__progress.dart';
import 'package:taskati/features/home/widgets/home_date_picer.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/task_builder.dart';
import 'package:taskati/features/task/page/add_tesk_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: widget.toggleTheme,
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              const HomeHeader(),

              const Gap(24),

              /// Progress
              const DailyProgress(),

              const Gap(24),

              /// 🔥 Date Picker
              HomeDatePicer(
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),

              const Gap(32),

              Expanded(
                child: TaskBuilder(
                  selectedDate: selectedDate,
                ),
              ),
            ],
          ),
        ),
      ),

      /// ➕ Add Task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pushto(context, AddTaskScreen(initialDate: selectedDate));
        },
        backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.add, color: AppColors.backgroundColor),
      ),
    );
  }
}
