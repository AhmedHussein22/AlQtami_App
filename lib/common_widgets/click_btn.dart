import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

class ClickButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final Color? textColor;
  final Color btnColor;
  final Widget? btnCenterWidget;
  final bool loading;

  const ClickButton({super.key, this.text = "", this.onPressed, this.width, this.height, this.decoration, this.textColor = AppColors.White_COLOR, this.btnColor = AppColors.KASHMIR_COLOR, this.btnCenterWidget, this.loading = false});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return loading
        ? Container(
            width: width ?? 0.9.sw,
            height: height ?? (1.sw < 600 ? 0.06.sh : 0.08.sh),
            decoration: decoration ??
                BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.circular(15.w),
                ),
            child: Center(
              child: UIGlobal.iPhoneLoading (context),
            ),
          )
        : InkWell(
            onTap: onPressed,
            child: Container(
              width: width ?? 0.9.sw,
              height: height ?? (1.sw < 600 ? 0.06.sh : 0.08.sh),
              decoration: decoration ??
                  BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(15.w),
                  ),
              child: Center(
                child: btnCenterWidget ??
                    Text(
                      text,
                      style: theme.textTheme.labelLarge!.copyWith(color: textColor),
                    ),
              ),
            ),
          );
  }
}
