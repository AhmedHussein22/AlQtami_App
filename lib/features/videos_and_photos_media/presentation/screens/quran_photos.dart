import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/common_widgets/click_btn.dart';
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/config/routes/app_routes.dart';

import 'alpitaqat_images.dart';

class QuranPhotos extends StatelessWidget {
  const QuranPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, "photo")),
      ),
      body: Column(
        children: [
          5.verticalSpace,
          ClickButton(
            text: "إذهب الي الصور المتنوعة",
            onPressed: () => Navigator.pushNamed(context, Routes.shortVideos),
          ),
          const Expanded(child: AlpitaqatImages()),
        ],
      ),
    );
  }
}
