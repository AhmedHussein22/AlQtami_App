// ignore_for_file: use_build_context_synchronously, avoid_single_cascade_in_expression_statements

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:naser_alqtami/config/routes/app_routes.dart';
import 'package:naser_alqtami/core/api/end_points.dart';

import '../../features/audios/presentation/widgets/play_audio/play_sura_audio.dart';
import '../../utils/app_utils/app_globals.dart';

class DynamicLinkHelper {
  Future<String> createProductDynamicLink(String endPoint) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: EndPoints.uriPrefixDeepLink,
      link: Uri.parse('https://mrcode.page.link/$endPoint'), //endPoint =quran/001
      androidParameters: const AndroidParameters(packageName: 'com.MRcode.Naser_Alqtami'),
      iosParameters: const IOSParameters(bundleId: 'com.MRcode.Naser_Alqtami'),
      // socialMetaTagParameters: const SocialMetaTagParameters(
      //   title: AppStrings.appName,
      //   description: "Naser Alqtami App for All Muslims",
      // ),
    );

    final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri dynamicLink = shortDynamicLink.shortUrl;

    return dynamicLink.toString();
  }

  static handleDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink;

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    Logger().i(deepLink);

    if (deepLink != null) {
      final String audioIndex = deepLink.pathSegments.last;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaySura(index: int.parse(audioIndex)),
        ),
      );
    }
  }

  void handleDynamicLink(PendingDynamicLinkData? data, context) {
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      Logger().i(deepLink);

      final String audioIndex = deepLink.pathSegments.last;
      Logger().wtf(audioIndex);
      if (audioIndex.contains("Alqtami_Radio")) {
        AppGloabl.navKey.currentState!.pushNamed(Routes.quranRadio);
      } else {
        AppGloabl.navKey.currentState!.push(
          MaterialPageRoute(
            builder: (context) => PlaySura(index: int.parse(audioIndex)),
          ),
        );
      }
    }
  }

  void initDynamicLinksListener(context) async {
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData? dynamicLink) async {
        handleDynamicLink(dynamicLink, context);
      },
      onError: (e) async {
        Logger().e(e);
      },
    );
  }
}
