import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class DailyProgress extends StatelessWidget {
  const DailyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat("EEEE,dd MMM yyyy").format(DateTime.now()),
                      style: TextStyles.caption1.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
                Gap(13),
                Row(
                  children: [
                    Text(
                      "Your today’s task almost almost",
                      style: TextStyles.caption1.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.backgroundColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CircularPercentIndicator(
            radius: 38,
            lineWidth: 8.0,
            percent: 0.85,
            center: Text(
              "85%",
              style: TextStyles.title.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.backgroundColor,
              ),
            ),
            progressColor: Colors.white,
            backgroundColor: Color(0xff8764FF),
          ),
        ],
      ),
    );
  }
}
