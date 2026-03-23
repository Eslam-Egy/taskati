import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/models/task_model.dart';
import 'package:taskati/core/servicer/hive_helper.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';
import 'package:taskati/features/task/widgets/res_container.dart';

class AddTaskScreen extends StatefulWidget {
  final DateTime? initialDate;
  const AddTaskScreen({super.key, this.initialDate});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late DateTime selectedDate = widget.initialDate ?? DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            "assets/images/Arrow - Left.svg",
            width: 24,
          ),
        ),
        title: Text(
          "Add Task",
          style: TextStyles.title.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight -
                    44,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(30),

                    /// Title
                    Text("Title",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    ),
                    const Gap(8),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF1E1E1E)
                            : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const Gap(20),

                    /// Description
                    Text("Description",
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    ),
                    const Gap(8),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF1E1E1E)
                            : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const Gap(40),

                    /// Date
                    ResContainer(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );

                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      icon: SvgPicture.asset("assets/images/calendar.svg", width: 24),
                      title: "Date",
                      value: DateFormat("dd MMM, yyyy").format(selectedDate),
                    ),

                    const Gap(24),

                    /// Start Time
                    ResContainer(
                      onTap: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: startTime,
                        );

                        if (picked != null) {
                          setState(() {
                            startTime = picked;
                          });
                        }
                      },
                      icon: SvgPicture.asset(
                        "assets/images/Time Circle.svg",
                        width: 24,
                      ),
                      title: "Start Time",
                      value: startTime.format(context),
                    ),

                    const Gap(24),

                    /// End Time
                    ResContainer(
                      onTap: () async {
                        TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: endTime,
                        );

                        if (picked != null) {
                          setState(() {
                            endTime = picked;
                          });
                        }
                      },
                      icon: SvgPicture.asset(
                        "assets/images/Time Circle.svg",
                        width: 24,
                      ),
                      title: "End Time",
                      value: endTime.format(context),
                    ),

                    const Spacer(),
                    const Gap(40),

                    /// Add Task Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          if (titleController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter task title"),
                              ),
                            );
                            return;
                          }

                          /// create unique key
                          final String key =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          HiveHelper.cacheTask(
                            key,
                            TaskModel(
                              id: key,
                              title: titleController.text,
                              description: descriptionController.text,
                              date: DateFormat("dd MMM, yyyy").format(selectedDate),
                              startTime: startTime.format(context),
                              endTime: endTime.format(context),
                              isCompleted: false,
                              createdAt: DateTime.now().toIso8601String(),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          "Add Task",
                          style: TextStyles.headline.copyWith(
                            color: AppColors.backgroundColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
