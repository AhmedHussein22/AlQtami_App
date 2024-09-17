import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/config/routes/app_routes.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/widgets/custom_list_tile.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/app_globals.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

import '../../../../on_boarding/presentation/bloc/locale_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIGlobal.appBar(
        context,
        tr(context, "setting"),
      ),
      // bottomNavigationBar: CustemBottomNavigationBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Text(
                tr(context, "language"),
                style: context.titleMediumS1.copyWith(color: AppColors.KASHMIR_COLOR),
              ),
            ),
            CustomListTile(
              title: tr(context, "lang"),
              isLast: true,
              onTap: () {
                if (AppLocalizations.of(context)!.isEnLocale) {
                  BlocProvider.of<LocaleCubit>(context).toArabic();
                } else {
                  BlocProvider.of<LocaleCubit>(context).toEnglish();
                }
              },
            ),
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Text(
                tr(context, "support"),
                style: context.titleMediumS1.copyWith(color: AppColors.KASHMIR_COLOR),
              ),
            ),
            CustomListTile(
              title: tr(context, "about"),
              onTap: () {
                Navigator.pushNamed(context, Routes.aboutUs);
              },
            ),
            CustomListTile(
              title: tr(context, "callus"),
              onTap: () {
                Navigator.pushNamed(context, '/CallUs');
              },
            ),
              
            CustomListTile(
              title: tr(context, "Privacy_policy"),
              onTap: () {
                AppGloabl.launchURL('https://www.freeprivacypolicy.com/live/d92e5cf3-33f7-4f13-8dc2-2584dcec85ac');
              },
            ),
            CustomListTile(
              title: tr(context, "Terms_and_Conditions"),
              onTap: () {
                AppGloabl.launchURL('https://www.app-privacy-policy.com/live.php?token=qfIfJyy8CQb9WLgzCuSOwmIFUJBQQdKa');
              },
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}
