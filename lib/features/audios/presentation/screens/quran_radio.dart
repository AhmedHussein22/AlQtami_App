// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/assets_manager.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/api/dynamic_link.dart';

class QuranRadio extends StatefulWidget {
  const QuranRadio({super.key});
  @override
  QuranRadioState createState() => QuranRadioState();
}

class QuranRadioState extends State<QuranRadio> {
  final just_audio.AudioPlayer _player = just_audio.AudioPlayer();
  double _volume = 1.0;
  Future<void> initLiveStream() async {
    try {
      await _player.setUrl('https://Qurango.net/radio/nasser_alqatami');
    } catch (e) {
      debugPrint("Error playing live stream: $e");
    }
  }

  void _onVolumeChanged(double value) {
    setState(() {
      _volume = value;
    });
    _player.setVolume(_volume);
  }

  void togglePlayback() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void setVolume(double volume) => _player.setVolume(volume);

  @override
  void initState() {
    super.initState();
    initLiveStream();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void shareSurah(String audioId) async {
    final String dynamicLink = await DynamicLinkHelper().createProductDynamicLink(audioId);
    Share.share('استمع الان الي راديو ناصر القطامى : $dynamicLink');
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
              padding: 8.hPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => shareSurah("Alqtami_Radio"),
                    icon: const Icon(CupertinoIcons.share_up, color: AppColors.White_COLOR),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.White_COLOR,
                      textDirection: !AppLocalizations.of(context)!.isEnLocale ? TextDirection.ltr : TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Playlist(),
                0.03.sh.verticalSpace,
                Text.rich(
                  TextSpan(
                    text: " راديو القطامي | Radio AlQatami\n",
                    style: context.titleMediumS1.copyWith(color: AppColors.White_COLOR),
                    children: [
                      TextSpan(
                        text: "ناصر القطامى",
                        style: context.titleMediumS1.copyWith(color: AppColors.White_COLOR.withOpacity(0.6), fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
                0.03.sh.verticalSpace,
                Center(
                  child: StreamBuilder<just_audio.PlayerState>(
                      stream: _player.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing ?? false;

                        // Show a loading icon if the audio is being loaded.
                        if (processingState == just_audio.ProcessingState.loading || processingState == just_audio.ProcessingState.buffering) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                            width: 32.0.r,
                            height: 32.0.r,
                            child: const CircularProgressIndicator(color: AppColors.White_COLOR),
                          );
                        }
                        return CircleAvatar(
                          radius: 1.sw > 600 ? 60 : 55,
                          backgroundColor: AppColors.White_COLOR.withOpacity(0.4),
                          child: Center(
                            child: IconButton(
                              icon: Icon(!playing ? Icons.play_arrow_rounded : Icons.pause_rounded, color: AppColors.White_COLOR, size: 1.sw > 600 ? 55 : 50),
                              padding: EdgeInsets.zero,
                              onPressed: togglePlayback,
                            ),
                          ),
                        );
                      }),
                ),
                0.04.sh.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(CupertinoIcons.volume_down, color: AppColors.White_COLOR),
                    Expanded(
                      child: Slider(
                        value: _volume,
                        min: 0.0,
                        max: 1.0,
                        activeColor: AppColors.White_COLOR.withOpacity(0.4),
                        inactiveColor: AppColors.White_COLOR.withOpacity(0.3),
                        thumbColor: AppColors.White_COLOR,
                        onChanged: _onVolumeChanged,
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.volume_up,
                      color: AppColors.White_COLOR,
                    ),
                  ],
                ),
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
