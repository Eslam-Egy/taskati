import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class TaskBuilder extends StatelessWidget {
  final DateTime selectedDate;

  const TaskBuilder({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          ButtonsTabBar(
            backgroundColor: AppColors.primaryColor,
            unselectedBackgroundColor:
                isDark ? const Color(0xFF2A2A2A) : const Color(0xffEDE7F6),
            unselectedLabelStyle: TextStyles.caption1.copyWith(
              color: AppColors.primaryColor,
            ),
            labelStyle: TextStyles.caption1.copyWith(color: Colors.white),
            radius: 12,
            height: 45,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            buttonMargin: const EdgeInsets.symmetric(horizontal: 8),
            tabs: const [
              Tab(text: "All"),
              Tab(text: "In Progress"),
              Tab(text: "Completed"),
            ],
          ),
          const Gap(20),
          Expanded(
            child: TabBarView(
              children: [
                TasksListView(
                  filter: "all",
                  selectedDate: selectedDate,
                ),
                TasksListView(
                  filter: "progress",
                  selectedDate: selectedDate,
                ),
                TasksListView(
                  filter: "completed",
                  selectedDate: selectedDate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TasksListView extends StatelessWidget {
  final String filter;
  final DateTime selectedDate;

  const TasksListView({
    super.key,
    required this.filter,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    final Box<TaskModel> box = Hive.box<TaskModel>('tasks');

    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box<TaskModel> box, _) {
        final selectedDateString =
            DateFormat("dd MMM, yyyy").format(selectedDate);

        List<TaskModel> tasks = box.values
            .where((task) => task.date == selectedDateString)
            .toList();

        /// ✅ فلترة بالحالة + التاريخ
        if (filter == "progress") {
          tasks = tasks.where((e) => !e.isCompleted).toList();
        } else if (filter == "completed") {
          tasks = tasks.where((e) => e.isCompleted).toList();
        }

        if (tasks.isEmpty) {
          return const Center(
            child: Text("No Tasks For This Day 😴"),
          );
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];

            final isDark = Theme.of(context).brightness == Brightness.dark;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(task.title ?? "", style: TextStyles.title),

                  const SizedBox(height: 6),

                  /// Description
                  Text(task.description ?? ""),

                  const SizedBox(height: 8),

                  /// Time
                  Text("${task.startTime} - ${task.endTime}"),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: task.isCompleted
                              ? Colors.green.shade100
                              : Colors.orange.shade100,
                        ),
                        child: Text(
                          task.isCompleted ? "Completed" : "In Progress",
                          style: TextStyles.caption2,
                        ),
                      ),

                      const Spacer(),

                      /// ✅ Complete
                      IconButton(
                        icon:
                            const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          task.isCompleted = !task.isCompleted;
                          task.save();
                        },
                      ),

                      /// 🗑 Delete
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          task.delete();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
