import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class TaskBuilder extends StatefulWidget {
  const TaskBuilder({super.key});

  @override
  State<TaskBuilder> createState() => _TaskBuilderState();
}

class _TaskBuilderState extends State<TaskBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonsTabBar(
          backgroundColor: AppColors.primaryColor,
            unselectedBackgroundColor: const Color(0xffEDE7F6),

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
              children: [TasksListView(), TasksListView(), TasksListView()],
            ),
          ),
        ],
      );
  }
}

class TasksListView extends StatelessWidget {
  const TasksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title Of Task", style: TextStyles.title),

              const Gap(6),

              Text(
                "Description Of Task",
                style: TextStyles.caption1.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),

              const Gap(8),

              Row(
                children: [
                  Image.asset(
                    "assets/images/Time Circle.png",
                    width: 20,
                    height: 20,
                  ),

                  const Gap(6),

                  Text(
                    "10:00 AM - 12:00 PM",
                    style: TextStyles.caption2.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),

                  const Spacer(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.accentColor,
                    ),
                    child: Text(
                      "In Progress",
                      style: TextStyles.caption2.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
