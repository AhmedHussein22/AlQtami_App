import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/app_strings.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../common_widgets/cach_network_image_wapper.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../data/models/quran_sur_model.dart';

class QuranVideoItem extends StatelessWidget {
  final int index;
  final AllQuran allQuran;
  const QuranVideoItem({super.key, required this.index, required this.allQuran});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: index,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.playYouTubeVideoRoute, arguments: index),
        child: SizedBox(
          width: 1.sw,
          height: 0.24.sh,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachNetworkImageWapper(
                  url: YoutubePlayer.getThumbnail(videoId: AppStrings.youTubeVideosIds[index]),
                  width: 1.sw,
                  hight: 0.24.sh,
                ),
              ),
              Center(
                  child: Icon(
                CupertinoIcons.play_arrow_solid,
                color: AppColors.DARK_BLUE_COLOR.withOpacity(0.4),
                size: 50,
              )),
              Container(
                padding: EdgeInsets.only(bottom: 25.h, right: 20.w),
                alignment: Alignment.bottomRight,
                child: Text(
                  "${allQuran.titleAr} | ${allQuran.title}",
                  style: context.displayMediumH2.copyWith(color: AppColors.KASHMIR_COLOR),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
