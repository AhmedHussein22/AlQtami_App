import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:naser_alqtami/features/audios/presentation/widgets/play_audio/quran_audio_item.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

import '../../../../common_widgets/error_widget.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';
import '../../../videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_state.dart';

class QuranAudio extends StatefulWidget {
  const QuranAudio({super.key});

  @override
  QuranAudioState createState() => QuranAudioState();
}

class QuranAudioState extends State<QuranAudio> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
   // _getQuranSur();
  }

  _getQuranSur() => BlocProvider.of<QuranSurCubit>(context).getQuranSur();

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIGlobal.appBar(context, tr(context, "quran_sound")),
      body: BlocBuilder<QuranSurCubit, QuranSurState>(
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
              child: ListView.separated(
                  controller: _scrollController,
                  itemCount: state.allQuranSur.allQuran.length,
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
      ),
    );
  }
}
