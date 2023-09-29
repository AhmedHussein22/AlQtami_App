import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

import '../../../../common_widgets/error_widget.dart';
import '../../../../config/locale/app_localizations.dart';
import '../cubits/quran_sur/quran_sur_cubit.dart';
import '../cubits/quran_sur/quran_sur_state.dart';
import '../widgets/quran_video/quran_video_item.dart';

class Quranvideo extends StatefulWidget {
  const Quranvideo({super.key});

  @override
  QuranvideoState createState() => QuranvideoState();
}

class QuranvideoState extends State<Quranvideo> {
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
      appBar: UIGlobal.appBar(context, tr(context, "quran_vedio")),
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
            return ListView.separated(
              controller: _scrollController,
              itemCount: state.allQuranSur.allQuran.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    QuranVideoItem(
                      index: index,
                      allQuran: state.allQuranSur.allQuran[index],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(
                color: AppColors.KASHMIR_COLOR,
                thickness: 4.h,
                height: 14.h,
              ),
            ).allPadding(8);
          } else {
            return UIGlobal.iPhoneLoading(context);
          }
        },
      ),
    );
  }
}
