import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taskati/core/styles/app_colors.dart';
import 'package:taskati/core/styles/text_styles.dart';

class ResContainer extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;
  final VoidCallback onTap;
  const ResContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          children: [
            icon,

            Gap(12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyles.title.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            Spacer(),

            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
