import 'package:flutter/material.dart';
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/config/routes/app_routes.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

class CateogeryLabel extends StatelessWidget {
  final String label;
  final int index;
  const CateogeryLabel({super.key, required this.label, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      tileColor: AppColors.GREY_COLOR,
      title: Text(
        label,
        style: context.titleMediumS1.copyWith(color: AppColors.DARK_BLUE_COLOR),
      ),
      trailing: TextButton(
          onPressed: () {
            if (index == 0) {
              Navigator.pushNamed(context, Routes.quranAudio);
            }
            if (index == 1) {
              Navigator.pushNamed(context, '/QuranAudio');
            }
            if (index == 2) {
              Navigator.pushNamed(context, '/Quranvideo');
            }
          },
          child: Text(
            tr(context, "all"),
            style: context.titleMediumS1.copyWith(color: AppColors.KASHMIR_COLOR),
          )),
    );
  }
}
