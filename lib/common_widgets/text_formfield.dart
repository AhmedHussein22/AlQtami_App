import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/app_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../config/locale/app_localizations.dart';

class CustomTextFormField extends StatelessWidget {
  final double? width;
  final String? hintText;
  final String? errorText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validatorFun;
  final int? maxLines;
  final TextInputType? textInputType;
  final bool isSecure;
  final bool readOnly;
  final bool titleWithRequiered;
  final Color backgroundColor;
  final Color borderColor;
  final Color? hintTextColor;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String title;
  final Key? filedKey;
  final TextEditingController? controller;

  const CustomTextFormField(
      {super.key,
      this.textInputType,
      this.maxLines,
      this.width,
      this.hintText = "",
      this.initialValue,
      this.errorText = "",
      this.title = '',
      this.onChanged,
      this.validatorFun,
      this.isSecure = false,
      this.readOnly = false,
      this.backgroundColor = AppColors.GREY_COLOR,
      this.borderColor = AppColors.KASHMIR_COLOR,
      this.hintTextColor,
      this.prefixIcon,
      this.suffix,
      this.filedKey,
      this.titleWithRequiered = false,
      this.controller});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 5.h, top: 8.h),
      width: width ?? 0.9.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 6.0.w),
              Text(
                title,
                style: context.displayMediumH2,
              ),
              if (titleWithRequiered)
                Text(
                  "*",
                  style: context.titleMediumS1.copyWith(color: AppColors.RED_COLOR),
                ),
            ],
          ),
          SizedBox(height: 5.0.h),
          TextFormField(
            initialValue: initialValue,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            validator: validatorFun ??
                (value) {
                  if (titleWithRequiered) return value == "" || value == null ? tr(context, "empty_text_field") : null;
                  return null;
                },
            controller: controller,
            obscureText: isSecure,
            readOnly: readOnly,
            key: filedKey,
            keyboardType: textInputType ?? TextInputType.text,
            style: context.displayMediumH2,
            cursorColor: AppColors.KASHMIR_COLOR,
            obscuringCharacter: "*",
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.start,
            maxLines: maxLines ?? 1,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffix,
              fillColor: backgroundColor,
              filled: true,
              hintText: hintText,
              hintStyle: context.titleMediumS1,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppGloabl.isTablet ? 0.03.sw : 0.05.sw,
                vertical: AppGloabl.isTablet ? 0.025.sh : 0.013.sh,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.w)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
