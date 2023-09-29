import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naser_alqtami/common_widgets/click_btn.dart';
import 'package:naser_alqtami/config/routes/app_routes.dart';
import 'package:naser_alqtami/core/api/end_points.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/app_globals.dart';
import 'package:naser_alqtami/utils/app_utils/assets_manager.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../../../../../config/locale/app_localizations.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.65.sw,
      height: 1.sh,
      child: Drawer(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagesPaths.derwerBG),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DrawerHeader(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ImagesPaths.logoWithoutBG),
                        ),
                      ),
                    ),
                  ),
                  CustemDrawerItem(title: tr(context, "home"), iconData: CupertinoIcons.home, route: Routes.homeScreenRoute),
                  CustemDrawerItem(title: tr(context, "quran_vedio"), imagePath: IconsPaths.quran, route: Routes.quranvideoRoute),
                  CustemDrawerItem(title: tr(context, "quran_sound"), imagePath: IconsPaths.volume, route: Routes.quranAudio),
                  CustemDrawerItem(title: tr(context, "sound"), iconData: CupertinoIcons.antenna_radiowaves_left_right, route: Routes.quranRadio),
                  CustemDrawerItem(title: tr(context, "vedio"), iconData: Icons.live_tv_rounded, route: Routes.quranLive),
                  CustemDrawerItem(title: tr(context, "photo"), imagePath: IconsPaths.photo, route: Routes.quranPhotos),
                  CustemDrawerItem(
                    title: tr(context, "short_videos"),
                    imagePath: IconsPaths.news,
                    route: Routes.shortVideos,
                    onPressed: () => AppGloabl.launchURL(EndPoints.googlePhotosVideos),
                  ),
                  2.divider,
                  CustemDrawerItem(title: tr(context, "favorites"), iconData: CupertinoIcons.heart_fill, route: Routes.favorites),
                  CustemDrawerItem(title: tr(context, "library"), iconData: CupertinoIcons.arrow_down_to_line, route: Routes.downloads),
                  CustemDrawerItem(title: tr(context, "setting"), iconData: CupertinoIcons.settings, route: '/Settings'),
                  ClickButton(
                    width: 0.5.sw,
                    text: tr(context, "callus"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/CallUs");
                    },
                  ).vPadding(8),
                ],
              ),
            )),
      ),
    );
  }
}

class CustemDrawerItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final IconData iconData;
  final String route;
  final VoidCallback? onPressed;
  const CustemDrawerItem({super.key, required this.title, this.imagePath = 'null', this.iconData = Icons.home, required this.route, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed ?? () => Navigator.popAndPushNamed(context, route),
      dense: true,
      mouseCursor: MouseCursor.defer,
      autofocus: true,
      title: Row(
        children: [
          imagePath.contains('null')
              ? Icon(
                  iconData,
                  color: AppColors.DARK_BLUE_COLOR,
                )
              : SvgPicture.asset(imagePath),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 8.w),
            child: Text(
              title,
              style: context.titleMediumS1.copyWith(color: AppColors.DARK_BLUE_COLOR),
            ),
          )
        ],
      ),
    );
  }
}
