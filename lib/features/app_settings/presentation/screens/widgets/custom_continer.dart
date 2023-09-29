import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

class CustomContainer extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final void Function()?  onTap;
  const CustomContainer({super.key, required this.icon, required this.text, required this.iconColor, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.White_COLOR,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(
              icon,
              size: 20,
              color: iconColor,
            ),
            Text(text, style: context.titleMediumS1.copyWith(color: AppColors.DARK_BLUE_COLOR))
          ],
        ),
      ),
    );
  }
}
