import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logger/logger.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../../../../utils/app_utils/preference.dart';
import '../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';
import '../../../videos_and_photos_media/presentation/widgets/quran_photos/pitaqa_item.dart';
import '../../../videos_and_photos_media/presentation/widgets/quran_photos/pitaqa_show_full_screen.dart';

class DownloadsPhotos extends StatefulWidget {
  const DownloadsPhotos({super.key});

  @override
  State<DownloadsPhotos> createState() => _DownloadsPhotosState();
}

class _DownloadsPhotosState extends State<DownloadsPhotos> {
  final List<String> _downloadsImages = [];
  @override
  void initState() {
    super.initState();
    _loaddownloadsImages();
  }

  Future<void> _loaddownloadsImages() async {
    final downloadsImagesIDs =
        await Preference.getStringList(PrefKeys.downloadImageIDs) ?? {};
    Logger().e(downloadsImagesIDs);

    setState(() => _downloadsImages.addAll(downloadsImagesIDs.toList()));
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuranSurCubit>(context).quranSur;

    return _downloadsImages.isEmpty
        ? const Center(child: Text("No Downloads"))
        : AnimationLimiter(
            child: GridView.builder(
              itemCount: _downloadsImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          RegExp regExp = RegExp(r'\d+');
                          Iterable<RegExpMatch>? matches =
                              regExp.allMatches(_downloadsImages[index]);
                          Match lastMatch = matches.last;
                          String imageIndex2 = lastMatch.group(0) ?? '';

                          Logger().i('imageIndex2: $imageIndex2');

                          //return Placeholder();
                          return PitaqaShowFullScreen(
                            imageIndex: int.parse(imageIndex2),
                            listLength: 1,
                            isFromDownLoads: true,
                            filesPaths: _downloadsImages,
                          );
                        },
                      ),
                    ),
                    child: PitaqaItem(
                      imageID: _downloadsImages[index],
                      isFromDownLoads: true,
                    ),
                  ),
                );
              },
            ).allPadding(8),
          );
  }
}
