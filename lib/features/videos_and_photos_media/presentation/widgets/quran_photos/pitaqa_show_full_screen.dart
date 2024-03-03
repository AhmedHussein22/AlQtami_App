import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

import '../../../../../common_widgets/cach_network_image_wapper.dart';
import '../../../../../core/api/end_points.dart';
import '../../../domain/entities/quran_surh.dart';
import '../../cubits/quran_sur/quran_sur_cubit.dart';

class PitaqaShowFullScreen extends StatefulWidget {
  final int imageIndex;
  final bool isFromDownLoads;
  final List<String>? filesPaths;
  final int? listLength;
  const PitaqaShowFullScreen({super.key, required this.imageIndex, this.listLength, this.isFromDownLoads = false, this.filesPaths});

  @override
  PitaqaShowFullScreenState createState() => PitaqaShowFullScreenState();
}

class PitaqaShowFullScreenState extends State<PitaqaShowFullScreen> {
  late PageController _pageController;
  int? _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.isFromDownLoads ? widget.imageIndex : widget.imageIndex ;
    _pageController = PageController();
    _pageController.addListener(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(_currentIndex!);
    });
  }

  void _scrollToIndex(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AllQuranSur surOfQuran = BlocProvider.of<QuranSurCubit>(context).quranSur!;
    print('widget.imageIndex: $_currentIndex');

    print('widget.imageIndex: ${surOfQuran.allQuran[_currentIndex ?? 0].index}');

    return Scaffold(
      appBar: UIGlobal.appBar(context, widget.isFromDownLoads ? tr(context, tr(context, "library")) : surOfQuran.allQuran[_currentIndex!].title),
      body: _currentIndex == null
          ? UIGlobal.iPhoneLoading(context)
          : PageView.builder(
              controller: _pageController,
              itemCount: widget.listLength ?? 114,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  child: widget.isFromDownLoads
                      ? Image.file(
                          File(widget.filesPaths![index]),
                          fit: BoxFit.contain,
                        )
                      : CachNetworkImageWapper(
                          url: '${EndPoints.albitaqatQuran}${surOfQuran.allQuran[_currentIndex ?? 0].index}.jpg',
                          fit: BoxFit.contain,
                        ),
                );
              },
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => _pageController.previousPage(duration: const Duration(milliseconds: 10), curve: Curves.bounceOut),
            icon: const Icon(Icons.navigate_before_rounded),
          ),
          IconButton(
            onPressed: () => _pageController.nextPage(duration: const Duration(milliseconds: 10), curve: Curves.bounceOut),
            icon: const Icon(Icons.navigate_next_rounded),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
