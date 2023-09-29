import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:naser_alqtami/core/api/end_points.dart';
import 'package:naser_alqtami/utils/app_utils/app_globals.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GooglePhotos extends StatefulWidget {
  const GooglePhotos({super.key});

  @override
  GooglePhotosState createState() => GooglePhotosState();
}

class GooglePhotosState extends State<GooglePhotos> {
  bool _isloading = true;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..canGoBack()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            UIGlobal.iPhoneLoading(context);
          },
          onPageStarted: (String url) {
            setState(() => _isloading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isloading = false);
          },
          onWebResourceError: (WebResourceError error) {
            UIGlobal.showErrorDialog(context: context, msg: error.description);
          },
          onNavigationRequest: (NavigationRequest request) async {
            Logger().e(request.url);
            if (request.url.startsWith('market://details?id=com.google')) {
              AppGloabl.launchURL(EndPoints.googlePhotosImages);
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://photos.google.com/share/AF1QipOyz26VFXZvMDH5f_bsH9STwiTJvUMjtKgdBuzBg_vUFZCKHg4dmvic8WbnsN1G-w?key=NFIxQmJ3cTZPMGdjNnpudndwU3hGdHQ1TVVsZG1B'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIGlobal.appBar(context, "google_photos"),
      body: _isloading
          ? UIGlobal.iPhoneLoading(context)
          : WebViewWidget(
              controller: controller,
            ),
    );
  }
}
