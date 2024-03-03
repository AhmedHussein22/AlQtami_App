import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logger/logger.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../../../../utils/app_utils/preference.dart';
import '../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';
import '../../../videos_and_photos_media/presentation/widgets/quran_photos/pitaqa_item.dart';
import '../../../videos_and_photos_media/presentation/widgets/quran_photos/pitaqa_show_full_screen.dart';

class FavoritesPhotos extends StatefulWidget {
  const FavoritesPhotos({super.key});

  @override
  State<FavoritesPhotos> createState() => _FavoritesPhotosState();
}

class _FavoritesPhotosState extends State<FavoritesPhotos> {
  final List<String> _favoritesImage = [];
  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final favoriteImageIDs =
        await Preference.getStringList(PrefKeys.favoriteImageIDs) ?? {};
    Logger().e(favoriteImageIDs);
    setState(() => _favoritesImage.addAll(favoriteImageIDs.toList()));
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuranSurCubit>(context).quranSur;

    return _favoritesImage.isEmpty
        ? const Center(child: Text("No Favorites"))
        : AnimationLimiter(
            child: GridView.builder(
              itemCount: _favoritesImage.length,
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
                        builder: (context) => PitaqaShowFullScreen(
                          imageIndex: int.parse(
                              _favoritesImage[index].replaceAll("0", '')),
                          listLength: 1,
                        ),
                      ),
                    ),
                    child: PitaqaItem(
                      imageID: _favoritesImage[index],
                    ),
                  ),
                );
              },
            ).allPadding(8),
          );
  }
}
