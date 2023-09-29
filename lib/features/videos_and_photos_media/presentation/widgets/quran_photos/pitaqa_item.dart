// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:logger/logger.dart';
import 'package:naser_alqtami/utils/app_utils/app_strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../common_widgets/cach_network_image_wapper.dart';
import '../../../../../config/locale/app_localizations.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../utils/app_utils/app_colors.dart';
import '../../../../../utils/app_utils/preference.dart';
import '../../../../../utils/ui_utils/ui_globals.dart';
import '../../../../audios/presentation/cubits/download_media/download_audio_cubit.dart';
import '../../../../audios/presentation/cubits/download_media/download_audio_state.dart';

class PitaqaItem extends StatefulWidget {
  final String imageID;
  final bool isFromDownLoads;
  const PitaqaItem({super.key, required this.imageID, this.isFromDownLoads = false});

  @override
  State<PitaqaItem> createState() => _PitaqaItemState();
}

class _PitaqaItemState extends State<PitaqaItem> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  void _loadFavorite() async {
    final favoriteImageIDs = await Preference.getStringList(PrefKeys.favoriteImageIDs) ?? {};
    final isFavorite = favoriteImageIDs.contains(widget.imageID);
    setState(() => _isFavorite = isFavorite);
  }

  void _toggleFavorite() async {
    final favoriteImageIDs = await Preference.getStringList(PrefKeys.favoriteImageIDs) ?? {};
    if (_isFavorite) {
      favoriteImageIDs.remove(widget.imageID);
      UIGlobal.showToast(msg: tr(context, "removefavours"));
    } else {
      favoriteImageIDs.add(widget.imageID);
      UIGlobal.showToast(msg: tr(context, "addfavours"));
    }
    Preference.setStringList(PrefKeys.favoriteImageIDs, favoriteImageIDs.toList());
    setState(() => _isFavorite = !_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      child: FadeInAnimation(
        child: Stack(
          children: [
            Container(
              height: 0.4.sh,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.KASHMIR_COLOR,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: widget.isFromDownLoads
                    ? Image.file(File(widget.imageID))
                    : CachNetworkImageWapper(
                        url: '${EndPoints.albitaqatQuran}${widget.imageID}.jpg',
                        fit: BoxFit.cover,
                        hight: 0.4.sh,
                      ),
              ),
            ),
            // Footer with icons
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.DARK_BLUE_COLOR.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.isFromDownLoads
                      ? [
                          IconButton(
                            onPressed: () async {
                              final downloadImages = await Preference.getStringList(PrefKeys.downloadImageIDs) ?? {};
                              bool removeDone = downloadImages.remove(widget.imageID);
                              if (removeDone) {
                                Preference.setStringList(PrefKeys.downloadImageIDs, downloadImages.toList());
                                UIGlobal.showToast(msg: "تم المسح من التنزيلات");
                              }
                            },
                            icon: const Icon(Icons.highlight_remove_rounded, color: AppColors.White_COLOR),
                          ),
                          IconButton(
                            onPressed: () {
                              Share.shareXFiles([XFile(widget.imageID)], text: AppStrings.appName);
                            },
                            icon: const Icon(Icons.reply, color: AppColors.White_COLOR),
                          ),
                        ]
                      : [
                          BlocBuilder<DownloadMediaCubit, DownloadMediaState>(builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                UIGlobal.showToast(msg: tr(context, 'addtodownload'));
                                final download = BlocProvider.of<DownloadMediaCubit>(context);
                                await download.downloadMedia(fileName: 'بطاقة رقم${widget.imageID}.jpg', path: '${EndPoints.albitaqatQuran}${widget.imageID}.jpg');

                                if (state is DownloadMediaComplete) {
                                  Directory appDocDirectory = await getApplicationDocumentsDirectory();
                                  final String filePath = '${appDocDirectory.path}/بطاقة رقم${widget.imageID}.jpg';
                                  Logger().d("pathhhhhhhhhhhhhhhhhhh0000 $filePath");
                                  final downloadImageIDs = await Preference.getStringList(PrefKeys.downloadImageIDs) ?? {};

                                  if (!downloadImageIDs.contains(filePath)) {
                                    downloadImageIDs.add(filePath);
                                    Preference.setStringList(PrefKeys.downloadImageIDs, downloadImageIDs.toList());
                                    Logger().e("ddddddddddddddddd${downloadImageIDs.toList()}");
                                    UIGlobal.showToast(msg: tr(context, 'completedDownload'));
                                  } else {
                                    UIGlobal.showToast(msg: tr(context, "alreadyDownload"));
                                  }
                                } else if (state is DownloadMediaError) {
                                  UIGlobal.showToast(msg: tr(context, 'fildDownload') + state.errormsg);
                                }
                              },
                              child: const Icon(CupertinoIcons.arrow_down_to_line, color: AppColors.White_COLOR),
                            );
                          }),
                          IconButton(
                            onPressed: _toggleFavorite,
                            icon: Icon(Icons.favorite, color: _isFavorite ? AppColors.RED_COLOR : AppColors.White_COLOR),
                          ),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
