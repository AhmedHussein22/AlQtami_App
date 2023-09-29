// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:naser_alqtami/core/api/dynamic_link.dart';
import 'package:naser_alqtami/core/api/end_points.dart';
import 'package:naser_alqtami/features/audios/presentation/cubits/download_media/download_audio_cubit.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:naser_alqtami/utils/app_utils/preference.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../config/locale/app_localizations.dart';
import '../../../../../utils/app_utils/app_strings.dart';
import '../../../../videos_and_photos_media/data/models/quran_sur_model.dart';
import '../../cubits/download_media/download_audio_state.dart';
import 'play_sura_audio.dart';

class AudioMediaCard extends StatefulWidget {
  final int index;
  final AllQuran allQuran;
  final bool isFromDonloads;
  final String? audioPath;
  const AudioMediaCard({super.key, required this.index, required this.allQuran, this.isFromDonloads = false, this.audioPath});

  @override
  AudioMediaCardState createState() => AudioMediaCardState();
}

class AudioMediaCardState extends State<AudioMediaCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  void _loadFavorite() async {
    final favoritesSurList = await Preference.getStringList(PrefKeys.favoriteSurList) ?? {};
    final isFavorite = favoritesSurList.contains(widget.index.toString());
    setState(() => _isFavorite = isFavorite);
  }

  void _toggleFavorite() async {
    final favoritesSurList = await Preference.getStringList(PrefKeys.favoriteSurList) ?? {};
    if (_isFavorite) {
      favoritesSurList.remove(widget.index.toString());
      UIGlobal.showToast(msg: tr(context, "removefavours"));
    } else {
      favoritesSurList.add(widget.index.toString());
      UIGlobal.showToast(msg: tr(context, "addfavours"));
    }
    Preference.setStringList(PrefKeys.favoriteSurList, favoritesSurList.toList());
    setState(() => _isFavorite = !_isFavorite);
  }

  void shareSurah(String audioId) async {
    final String dynamicLink = await DynamicLinkHelper().createProductDynamicLink(audioId);
    Share.share('استمع الان الي ناصر القطامى سورة ${widget.allQuran.titleAr} : $dynamicLink');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: 8.vPadding,
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaySura(index: widget.index),
              ),
            );
          },
          dense: false,
          visualDensity: const VisualDensity(vertical: 0.0, horizontal: 0.0),
          leading: CircleAvatar(
            radius: 1.sh * 0.12 / 3,
            backgroundColor: AppColors.GREY_COLOR,
            child: const Icon(Icons.headset, color: AppColors.DARK_BLUE_COLOR),
          ),
          title: Text(
            "سورة ${widget.allQuran.titleAr}",
            style: context.titleMediumS1.copyWith(color: AppColors.DARK_BLUE_COLOR),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: _toggleFavorite,
                child: Icon(Icons.favorite, color: _isFavorite ? AppColors.RED_COLOR : AppColors.DARK_BLUE_COLOR),
              ),
              0.02.sw.horizontalSpace,
              InkWell(
                onTap: widget.isFromDonloads ? () => Share.shareXFiles([XFile(widget.audioPath!)], text: AppStrings.appName) : () => shareSurah('quransurah/${widget.index.toString()}'),
                child: const Icon(Icons.reply, color: AppColors.DARK_BLUE_COLOR),
              ),
              0.02.sw.horizontalSpace,
              BlocBuilder<DownloadMediaCubit, DownloadMediaState>(builder: (context, state) {
                return InkWell(
                  onTap: widget.isFromDonloads
                      ? () async {
                          final downloadSurListPaths = await Preference.getStringList(PrefKeys.downloadSurListPaths) ?? {};
                          bool removeDone = downloadSurListPaths.remove(widget.audioPath);
                          if (removeDone) {
                            Preference.setStringList(PrefKeys.downloadSurListPaths, downloadSurListPaths.toList());
                            UIGlobal.showToast(msg: "تم المسح من التنزيلات");
                          }
                        }
                      : () async {
                          UIGlobal.showToast(msg: tr(context, 'addtodownload'));
                          final download = BlocProvider.of<DownloadMediaCubit>(context);
                          await download.downloadMedia(fileName: '${widget.allQuran.index}.mp3', path: "${EndPoints.quranAudio + widget.allQuran.index}.mp3");
                          if (state is DownloadMediaComplete) {
                            Directory appDocDirectory = await getApplicationDocumentsDirectory();
                            final String filePath = '${appDocDirectory.path}/${widget.allQuran.index}.mp3';
                            Logger().d("pathhhhhhhhhhhhhhhhhhh0000 $filePath");

                            final downloadSurPaths = await Preference.getStringList(PrefKeys.downloadSurListPaths) ?? {};
                            Logger().d("pathhhhhhhhhhhhhhhhhhh0000 $downloadSurPaths");

                            if (!downloadSurPaths.contains(filePath)) {
                              downloadSurPaths.add(filePath);
                              Preference.setStringList(PrefKeys.downloadSurListPaths, downloadSurPaths.toList());
                              UIGlobal.showToast(msg: tr(context, 'completedDownload'));
                            } else {
                              UIGlobal.showToast(msg: tr(context, "alreadyDownload"));
                            }
                          } else if (state is DownloadMediaError) {
                            UIGlobal.showToast(msg: tr(context, 'fildDownload') + state.errormsg);
                          }
                        },
                  child: Icon(widget.isFromDonloads ? Icons.file_download_off_rounded : Icons.cloud_download, color: AppColors.DARK_BLUE_COLOR),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
