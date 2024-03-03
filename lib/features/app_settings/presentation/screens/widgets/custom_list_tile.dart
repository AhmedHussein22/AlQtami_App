import 'package:flutter/material.dart';
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final bool isLast;
  const CustomListTile(
      {super.key, this.title, this.onTap, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.White_COLOR,
          border: isLast
              ? null
              : const Border(
                  bottom: BorderSide(width: 1, color: AppColors.KASHMIR_COLOR)),
        ),
        child: ListTile(
          title: Text(
            title ?? '',
            style: context.titleMediumS1
                .copyWith(color: AppColors.DARK_BLUE_COLOR),
          ),
          trailing: Icon(
            (!AppLocalizations.of(context)!.isEnLocale)
                ? Icons.keyboard_arrow_left
                : Icons.keyboard_arrow_right,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
