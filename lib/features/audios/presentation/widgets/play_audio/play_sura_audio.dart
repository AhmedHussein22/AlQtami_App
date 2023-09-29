// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/assets_manager.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../config/locale/app_localizations.dart';
import '../../../../../core/api/dynamic_link.dart';
import '../../../../../core/play_audio/notifiers/play_button_notifier.dart';
import '../../../../../core/play_audio/notifiers/progress_notifier.dart';
import '../../../../../core/play_audio/notifiers/repeat_button_notifier.dart';
import '../../../../../core/play_audio/player_manager/page_manager.dart';
import '../../../../../injection_container.dart';
import '../../../../../utils/app_utils/preference.dart';
import '../../../../../utils/ui_utils/ui_globals.dart';
import '../../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';

class PlaySura extends StatefulWidget {
  final int index;

  const PlaySura({super.key, required this.index});
  @override
  PlaySuraState createState() => PlaySuraState();
}

class PlaySuraState extends State<PlaySura> {
  bool _isFavorite = false;
  @override
  void initState() {
    super.initState();
    goToSurah();
    _loadFavorite();
  }

  goToSurah({int? surahIndex}) {
    final pageManager = serviceLoctor<PageManager>();
    pageManager.skipToQueue(surahIndex ?? widget.index);
  }

  void _loadFavorite() async {
    final favoritesSurList = await Preference.getStringList(PrefKeys.favoriteSurList) ?? {};
    final isFavorite = favoritesSurList.contains(widget.index.toString());
    setState(() => _isFavorite = isFavorite);
  }

  void shareSurah(String audioId) async {
    final String dynamicLink = await DynamicLinkHelper().createProductDynamicLink(audioId);
    Share.share('استمع الان الي ناصر القطامى : $dynamicLink');
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set the status bar color.
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Image.asset(
                  ImagesPaths.intro3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0.15.sh,
              left: 0.08.sw,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  ImagesPaths.intro3,
                  height: 0.84.sw,
                  width: 0.84.sw,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //! TO support RTL and LTR use this

            Container(
              margin: 0.04.sh.vPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => UIGlobal.showCupertinoActionSheet(context, const AudioPlayList()),
                    icon: const Icon(Icons.format_list_bulleted_rounded, color: AppColors.White_COLOR),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.cloud_download_rounded, color: AppColors.White_COLOR),
                  ),
                  IconButton(
                    onPressed: () => shareSurah("quransurah/${widget.index.toString()}"),
                    icon: const Icon(CupertinoIcons.share_up, color: AppColors.White_COLOR),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.White_COLOR),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Playlist(),
                TitleAndActionsButtons(isFav: _isFavorite, index: widget.index),
                0.07.sh.verticalSpace,
                const AudioProgressBar(),
                0.03.sh.verticalSpace,
                const AudioControlButtons(),
                0.073.sh.verticalSpace,
              ],
            ).allPadding(20),
          ],
        ),
      ),
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Expanded(child: SingleChildScrollView());
  }
}

class TitleAndActionsButtons extends StatefulWidget {
  bool isFav;
  final int index;
  TitleAndActionsButtons({Key? key, required this.isFav, required this.index}) : super(key: key);

  @override
  State<TitleAndActionsButtons> createState() => _TitleAndActionsButtonsState();
}

class _TitleAndActionsButtonsState extends State<TitleAndActionsButtons> {
  void _toggleFavorite() async {
    final favoritesSurList = await Preference.getStringList(PrefKeys.favoriteSurList) ?? {};
    if (widget.isFav) {
      favoritesSurList.remove(widget.index.toString());
      UIGlobal.showToast(msg: tr(context, "removefavours"));
    } else {
      favoritesSurList.add(widget.index.toString());
      UIGlobal.showToast(msg: tr(context, "addfavours"));
    }
    Preference.setStringList(PrefKeys.favoriteSurList, favoritesSurList.toList());
    setState(() => widget.isFav = !widget.isFav);
  }

  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLoctor<PageManager>();
    final quranSur = BlocProvider.of<QuranSurCubit>(context).quranSur;
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (context, index, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: "${quranSur!.allQuran[int.parse(index) - 1].titleAr} | ${quranSur.allQuran[int.parse(index) - 1].title}\n",
                style: context.titleMediumS1.copyWith(color: AppColors.White_COLOR),
                children: [
                  TextSpan(
                    text: "ناصر القطامى",
                    style: context.titleMediumS1.copyWith(color: AppColors.White_COLOR.withOpacity(0.6), fontSize: 14.sp),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: _toggleFavorite,
              icon: widget.isFav ? const Icon(CupertinoIcons.heart_fill, color: AppColors.RED_COLOR) : const Icon(CupertinoIcons.heart, color: AppColors.White_COLOR),
            )
          ],
        );
      },
    );
  }
}

class AudioPlayList extends StatelessWidget {
  const AudioPlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLoctor<PageManager>();
    final quranSur = BlocProvider.of<QuranSurCubit>(context).quranSur;

    return ValueListenableBuilder<List<String>>(
      valueListenable: pageManager.playlistNotifier,
      builder: (_, value, __) {
        return SizedBox(
          height: 0.6.sh,
          child: ListView.separated(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return CupertinoActionSheetAction(
                child: Text(
                  "${quranSur!.allQuran[index].titleAr} | ${quranSur.allQuran[index].title}",
                ),
                onPressed: () {
                  // Handle option 1 action
                  Navigator.pop(context);
                  pageManager.skipToQueue(index);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        );
      },
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLoctor<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
          barHeight: 2.h,
          thumbGlowRadius: 20.r,
          thumbRadius: 5.r,
          baseBarColor: AppColors.White_COLOR.withOpacity(0.3),
          bufferedBarColor: AppColors.White_COLOR.withOpacity(0.4),
          progressBarColor: AppColors.White_COLOR,
          thumbColor: AppColors.White_COLOR,
          timeLabelTextStyle: context.titleMediumS1.copyWith(color: AppColors.White_COLOR.withOpacity(0.5)),
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLoctor<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(CupertinoIcons.repeat, color: AppColors.White_COLOR.withOpacity(0.4));
            break;
          case RepeatState.repeatSong:
            icon = const Icon(CupertinoIcons.repeat_1);
            break;
          case RepeatState.repeatPlaylist:
            icon = const Icon(CupertinoIcons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          hoverColor: AppColors.White_COLOR,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLoctor<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(CupertinoIcons.backward_end_fill, color: isFirst ? AppColors.White_COLOR.withOpacity(0.4) : AppColors.White_COLOR, size: 1.sw > 600 ? 35 : 22),
          onPressed: (isFirst) ? null : pageManager.previous,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLoctor<PageManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0.w),
              width: 32.0.r,
              height: 32.0.r,
              child: const CircularProgressIndicator(color: AppColors.White_COLOR),
            );
          case ButtonState.paused:
            return CircleAvatar(
              radius: 1.sw > 600 ? 30 : 28,
              backgroundColor: AppColors.White_COLOR.withOpacity(0.4),
              child: IconButton(
                icon: Icon(Icons.play_arrow_rounded, color: AppColors.White_COLOR, size: 1.sw > 600 ? 45 : 40),
                padding: EdgeInsets.zero,
                onPressed: pageManager.play,
              ),
            );
          case ButtonState.playing:
            return CircleAvatar(
              radius: 1.sw > 600 ? 30 : 28,
              backgroundColor: AppColors.White_COLOR.withOpacity(0.4),
              child: IconButton(
                icon: Icon(Icons.pause_rounded, color: AppColors.White_COLOR, size: 1.sw > 600 ? 45 : 40),
                padding: EdgeInsets.zero,
                onPressed: pageManager.pause,
              ),
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLoctor<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(CupertinoIcons.forward_end_fill, color: isLast ? AppColors.White_COLOR.withOpacity(0.4) : AppColors.White_COLOR, size: 1.sw > 600 ? 35 : 22),
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLoctor<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled) ? const Icon(CupertinoIcons.shuffle, color: AppColors.White_COLOR) : Icon(CupertinoIcons.shuffle, color: AppColors.White_COLOR.withOpacity(0.4)),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}
