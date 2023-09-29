import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/utils/app_utils/app_strings.dart';
import '../../utils/app_utils/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.GREY_COLOR,
    cardColor: AppColors.White_COLOR,
    scaffoldBackgroundColor: AppColors.GREY_COLOR,
    fontFamily: AppStrings.fontFamily,
    appBarTheme: AppBarTheme(
      color: AppColors.DARK_BLUE_COLOR,
      elevation: 0.0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColors.White_COLOR,
        size: 18.sp, //change your color here
      ),
    ),
    iconTheme: IconThemeData(
      size: 24.r,
      color: AppColors.DARK_BLUE_COLOR,
      
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      indent: 10.w,
      endIndent: 10.w,
      color: AppColors.KASHMIR_COLOR,
      space: 1,
    ),
    cardTheme: CardTheme(
      color: AppColors.White_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      elevation: 0.0,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.DARK_BLUE_COLOR,
      inactiveTrackColor: AppColors.KASHMIR_COLOR,
      thumbColor: AppColors.DARK_BLUE_COLOR,
      trackHeight: 3,
      thumbShape: RoundSliderThumbShape(
        enabledThumbRadius: 8.r,
        disabledThumbRadius: 8.r,
        elevation: 0.0,
      ),
    ),
    textTheme: TextTheme(
      //// ! h1
      displayLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.White_COLOR,
      ),
      //// ! h1
      displayMedium: TextStyle(
        fontSize: 16.sp,
        color: AppColors.White_COLOR,
        fontWeight: FontWeight.w500,
      ),
      //// ! h1
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.KASHMIR_COLOR,
      ),
    ),
  );
}
