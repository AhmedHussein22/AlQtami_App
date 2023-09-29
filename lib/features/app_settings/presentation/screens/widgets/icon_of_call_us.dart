import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/app_globals.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../../../../../config/locale/app_localizations.dart';

class CallUsIcons extends StatelessWidget {
  const CallUsIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        children: [
          Text(tr(context, "follow_us"), style: context.titleMediumS1.copyWith(color: AppColors.DARK_BLUE_COLOR)),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => AppGloabl.launchURL('https://www.facebook.com/ahmed2422'),
                child: FaIcon(
                  FontAwesomeIcons.facebook,
                  size: 30,
                  color: Colors.blue.shade900,
                ),
              ),
              GestureDetector(
                onTap: () => AppGloabl.launchURL('https://github.com/AhmedHussein22'),
                child: const FaIcon(
                  FontAwesomeIcons.github,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () => AppGloabl.launchURL('https://www.linkedin.com/in/ahmed-hussein-66b1b71a5/'),
                child: FaIcon(
                  FontAwesomeIcons.linkedin,
                  size: 30,
                  color: Colors.blue.shade700,
                ),
              ),
              GestureDetector(
                onTap: () => AppGloabl.launchURL('https://www.instagram.com/engahmedhussein8/'),
                child: FaIcon(
                  FontAwesomeIcons.instagram,
                  size: 30,
                  color: Colors.red.shade500,
                ),
              ),
            ],
          ).vPadding(10),
        ],
      ),
    );
  }
}
