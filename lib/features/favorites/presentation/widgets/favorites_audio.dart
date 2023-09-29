import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logger/logger.dart';

import '../../../../utils/app_utils/preference.dart';
import '../../../audios/presentation/widgets/play_audio/quran_audio_item.dart';
import '../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';

class FavoritesAudio extends StatefulWidget {
  const FavoritesAudio({super.key});

  @override
  State<FavoritesAudio> createState() => _FavoritesAudioState();
}

class _FavoritesAudioState extends State<FavoritesAudio> {
  final List<String> _favoritesAudio = [];
  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final favoriteSurList = await Preference.getStringList(PrefKeys.favoriteSurList) ?? {};

    setState(() => _favoritesAudio.addAll(favoriteSurList.toList()));
    Logger().e(_favoritesAudio);
  }

  @override
  Widget build(BuildContext context) {
    final quranSur = BlocProvider.of<QuranSurCubit>(context).quranSur!;
    return AnimationLimiter(
      child: ListView.separated(
          itemCount: _favoritesAudio.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FlipAnimation(
                  child: AudioMediaCard(
                    allQuran: quranSur.allQuran[int.parse(_favoritesAudio[index])],
                    index: int.parse(_favoritesAudio[index]),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => 8.verticalSpace),
    );
  }
}
