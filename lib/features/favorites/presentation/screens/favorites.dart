import 'package:flutter/material.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../../../../config/locale/app_localizations.dart';
import '../widgets/favorites_audio.dart';
import '../widgets/favorites_photos.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr(context, "favorites")),
          bottom: TabBar(
            indicatorColor: AppColors.KASHMIR_COLOR,
            
            tabs: [
              Tab(
                child: Text(tr(context, 'photo'), style: context.displayMediumH2),
              ),
              Tab(
                child: Text(tr(context, 'quran_sound'), style: context.displayMediumH2),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FavoritesPhotos(),
            FavoritesAudio(),
          ],
        ),
      ),
    );
  }
}
