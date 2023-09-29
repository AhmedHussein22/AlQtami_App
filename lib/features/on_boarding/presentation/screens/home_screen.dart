import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:naser_alqtami/config/routes/app_routes.dart';
import 'package:naser_alqtami/core/api/end_points.dart';
import 'package:naser_alqtami/features/audios/presentation/widgets/play_audio/quran_audio_item.dart';
import 'package:naser_alqtami/utils/app_utils/assets_manager.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../../../../common_widgets/click_btn.dart';
import '../../../../common_widgets/error_widget.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../utils/app_utils/app_globals.dart';
import '../../../../utils/ui_utils/ui_globals.dart';
import '../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';
import '../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_state.dart';
import 'widgets/cateogery_label.dart';
import 'widgets/derwer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: UIGlobal.appBar(context, tr(context, "home")),
      // bottomNavigationBar: const BaseBottomNavigationBar(),
      drawer: const HomeDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                //*************** Buttons ******************/
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      10.horizontalSpace,
                      ClickButton(
                        text: tr(context, "short_videos"),
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        onPressed: () => AppGloabl.launchURL(EndPoints.googlePhotosVideos),
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      ClickButton(
                        text: tr(context, "sound"),
                        width: size.width * 0.35,
                        height: size.height * 0.06,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.quranRadio);
                        },
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      ClickButton(
                        text: tr(context, "vedio"),
                        width: size.width * 0.35,
                        height: size.height * 0.06,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.quranLive);
                        },
                      ),
                      10.horizontalSpace,
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

                //*************** Sliders ******************/

                SizedBox(
                  height: size.height * 0.25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      const List<String> images = [ImagesPaths.intro2, ImagesPaths.intro3, ImagesPaths.intro1];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //*************** quran_sound ******************/

                CateogeryLabel(label: tr(context, "quran_sound"), index: 0).hPadding(10),

                BlocBuilder<QuranSurCubit, QuranSurState>(
                  builder: (context, state) {
                    if (state is QuranSurIsLoading) {
                      return UIGlobal.iPhoneLoading(context);
                    } else if (state is QuranSurError) {
                      return OnErrorWidget(
                        errorMsg: state.errormsg,
                        //onPress: () => _getQuranSur(),
                      );
                    } else if (state is QuranSurLoaded) {
                      return AnimationLimiter(
                        child: ListView.separated(
                            itemCount: 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                delay: const Duration(milliseconds: 100),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FlipAnimation(
                                    child: AudioMediaCard(
                                      allQuran: state.allQuranSur.allQuran[index],
                                      index: index,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => 8.verticalSpace),
                      );
                    } else {
                      return UIGlobal.iPhoneLoading(context);
                    }
                  },
                ).hPadding(10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
