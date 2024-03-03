import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logger/logger.dart';

import '../../../../utils/app_utils/preference.dart';
import '../../../audios/presentation/widgets/play_audio/quran_audio_item.dart';
import '../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';

class DownloadsAudio extends StatefulWidget {
  const DownloadsAudio({super.key});

  @override
  State<DownloadsAudio> createState() => _DownloadsAudioState();
}

class _DownloadsAudioState extends State<DownloadsAudio> {
  final List<String> _downloadsAudio = [];
  @override
  void initState() {
    super.initState();
    _loadDownloads();
  }

  Future<void> _loadDownloads() async {
    final loadDownloadsSurList =
        await Preference.getStringList(PrefKeys.downloadSurListPaths) ?? {};
    setState(() => _downloadsAudio.addAll(loadDownloadsSurList.toList()));
    Logger().e(_downloadsAudio);
  }

  @override
  Widget build(BuildContext context) {
    final quranSur = BlocProvider.of<QuranSurCubit>(context).quranSur!;
    return _downloadsAudio.isEmpty
        ? const Center(child: Text("No Downloads"))
        : AnimationLimiter(
            child: ListView.separated(
                itemCount: _downloadsAudio.length,
                itemBuilder: (context, index) {
                  RegExp regExp = RegExp(r'(\d+)\.mp3$');
                  Match? match = regExp.firstMatch(_downloadsAudio[index]);

                  String audioIndex = match!.group(1) ?? '0';
                  Logger().d("audioIndexaudioIndexaudioIndex $audioIndex");
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    delay: const Duration(milliseconds: 100),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FlipAnimation(
                        child: AudioMediaCard(
                          allQuran:
                              quranSur.allQuran[int.parse(audioIndex) - 1],
                          index: int.parse(audioIndex) - 1,
                          audioPath: _downloadsAudio[index],
                          isFromDonloads: true,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => 8.verticalSpace),
          );
  }
}
