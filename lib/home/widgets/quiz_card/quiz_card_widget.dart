import 'package:flutter/material.dart';

import 'package:stpzogo/core/core.dart';
import 'package:stpzogo/shared/widgets/progress_indicator/progress_indicator_widget.dart';

class QuizCardWidget extends StatelessWidget {
  final String title;
  final String completed;
  final double percent;
  final VoidCallback onTap;
  const QuizCardWidget({
    Key? key,
    required this.title,
    required this.completed,
    required this.percent,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(color: AppColors.border)),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(
              height: 40,
              width: 40,
              child: Image.asset(AppImages.blocks),
            ),
           const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.heading15,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    completed,
                    style: AppTextStyles.body11,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: ProgressIndicatorWidget(
                      value: percent,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
