// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/presentation/widgets/quran_photos/pitaqa_item.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../../../../common_widgets/error_widget.dart';
import '../../../../utils/ui_utils/ui_globals.dart';
import '../cubits/quran_sur/quran_sur_cubit.dart';
import '../cubits/quran_sur/quran_sur_state.dart';
import '../widgets/quran_photos/pitaqa_show_full_screen.dart';

class AlpitaqatImages extends StatefulWidget {
  const AlpitaqatImages({super.key});

  @override
  State<AlpitaqatImages> createState() => _AlpitaqatImagesState();
}

class _AlpitaqatImagesState extends State<AlpitaqatImages> {
  _getQuranSur() => BlocProvider.of<QuranSurCubit>(context).getQuranSur();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranSurCubit, QuranSurState>(
      builder: (context, state) {
        if (state is QuranSurIsLoading) {
          return UIGlobal.iPhoneLoading(context);
        } else if (state is QuranSurError) {
          return OnErrorWidget(
            errorMsg: state.errormsg,
            onPress: () => _getQuranSur(),
          );
        } else if (state is QuranSurLoaded) {
          return AnimationLimiter(
            child: GridView.builder(
              itemCount: state.allQuranSur.allQuran.length,
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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PitaqaShowFullScreen(imageIndex: index))),
                    child: PitaqaItem(imageID: (index + 1).toString().padLeft(3, "0"))),
                );
              },
            ).allPadding(8),
          );
        } else {
          return UIGlobal.iPhoneLoading(context);
        }
      },
    );
  }
}
