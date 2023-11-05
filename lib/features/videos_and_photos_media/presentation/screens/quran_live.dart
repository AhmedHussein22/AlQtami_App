import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../config/locale/app_localizations.dart';

class QuranLive extends StatefulWidget {
  const QuranLive({super.key});

  @override
  QuranLiveState createState() => QuranLiveState();
}

class QuranLiveState extends State<QuranLive> {
  YoutubePlayerController? _youtubePlayerController;

  double _volume = 100;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: "Zi158ArXdbg",
      flags: const YoutubePlayerFlags(isLive: true),
    )..addListener(listener);
  }

  void listener() {
    if (_isPlayerReady && mounted && !_youtubePlayerController!.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    _youtubePlayerController!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubePlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIGlobal.appBar(context, tr(context, "is_running")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _youtubePlayerController!,
                showVideoProgressIndicator: true,
                progressColors: const ProgressBarColors(playedColor: AppColors.RED_COLOR, handleColor: AppColors.RED_COLOR),
                bottomActions: [
                  CurrentPosition(controller: _youtubePlayerController!),
                  ProgressBar(
                    isExpanded: true,
                    controller: _youtubePlayerController!,
                    colors: const ProgressBarColors(playedColor: AppColors.RED_COLOR, handleColor: AppColors.RED_COLOR),
                  ),
                  RemainingDuration(controller: _youtubePlayerController!),
                  PlaybackSpeedButton(controller: _youtubePlayerController!),
                ],
                onReady: () {
                  _isPlayerReady = true;
                },
              ),
              builder: (context, plyer) {
                return Column(
                  children: [
                    //! play and title
                    plyer,

                    0.01.sh.verticalSpace,
                    Text(
                      _youtubePlayerController!.metadata.title,
                      style: context.displayMediumH2.copyWith(color: AppColors.DARK_BLUE_COLOR),
                      textAlign: TextAlign.center,
                    ).hPadding(10),
                    Text(
                      _youtubePlayerController!.metadata.author,
                      style: context.titleMediumS1.copyWith(color: AppColors.DARK_BLUE_COLOR),
                    ),
                    60.verticalSpace,
                    //! buttons functions
                    !_isPlayerReady
                        ? UIGlobal.iPhoneLoading(context)
                        : Column(
                            children: [
                              // BlocBuilder<LocaleCubit, LocaleState>(builder: (context, state) {
                              //   return Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       IconButton(
                              //           icon: Icon(
                              //             CupertinoIcons.backward_end_fill,
                              //             color: currentIndex == 0 ? AppColors.KBorder_Gray_COLOR : AppColors.DARK_BLUE_COLOR,
                              //             size: 1.sw > 600 ? 50 : 35,
                              //           ),
                              //           onPressed: () {
                              //             if (currentIndex != 0) {
                              //               _youtubePlayerController!.load(AppStrings.youTubeVideosIds[currentIndex - 1]);
                              //               currentIndex--;
                              //             }
                              //           }),
                              //       IconButton(
                              //         icon: Icon(_youtubePlayerController!.value.isPlaying ? CupertinoIcons.pause_circle : CupertinoIcons.play_circle, color: AppColors.DARK_BLUE_COLOR, size: 1.sw > 600 ? 50 : 45),
                              //         onPressed: () => _youtubePlayerController!.value.isPlaying ? _youtubePlayerController!.pause() : _youtubePlayerController!.play(),
                              //       ),
                              //       IconButton(
                              //           icon: Icon(CupertinoIcons.forward_end_fill, color: currentIndex == 113 ? AppColors.KBorder_Gray_COLOR : AppColors.DARK_BLUE_COLOR, size: 1.sw > 600 ? 50 : 35),
                              //           onPressed: () {
                              //             if (currentIndex != 113) {
                              //               _youtubePlayerController!.load(AppStrings.youTubeVideosIds[currentIndex + 1]);
                              //               currentIndex++;
                              //             }
                              //           }),
                              //     ],
                              //   ).vPadding(15);
                              // }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.volume_off,
                                    color: AppColors.DARK_BLUE_COLOR,
                                    size: 1.sw > 600 ? 50 : 35,
                                  ),
                                  Expanded(
                                    child: Slider(
                                      value: _volume,
                                      max: 100,
                                      divisions: 100,
                                      label: _volume.round().toString(),
                                      onChanged: (double value) {
                                        _volume = value;
                                        _youtubePlayerController!.setVolume(_volume.round());
                                      },
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.volume_up,
                                    color: AppColors.DARK_BLUE_COLOR,
                                    size: 1.sw > 600 ? 50 : 35,
                                  ),
                                ],
                              ),
                            ],
                          ).hPadding(10),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
