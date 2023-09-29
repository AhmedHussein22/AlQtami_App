import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';
import 'package:url_launcher/url_launcher.dart';

class AppGloabl {
  static bool isTablet = 1.sw > 600 ? true : false;
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static void copyText(context, {required String text}) {
    Clipboard.setData(
      ClipboardData(text: text),
    ).then(
      (value) {
        UIGlobal.showToast(msg: tr(context, "copied"));
      },
    );
  }

  static Future<void> openGoogleMap(double latitude, double longitude, context) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      UIGlobal.showToast(msg: tr(context, "Can not Open Map"));
      throw 'Could not open the map';
    }
  }

  static launchURL(String url,{LaunchMode? launchMode}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode:launchMode?? LaunchMode.externalApplication,
      );
    } else {
      UIGlobal.showToast(msg: "Could not launch $url");
    }
  }

  static openWhatsapp(context, String whatsapp) async {
    String whatsappNumder = whatsapp.startsWith("+") ? whatsapp : "+2$whatsapp";
    String url = "https://wa.me/$whatsappNumder/?text=${Uri.encodeFull("Hello World !! Hey There")}";
    final Uri whatsappURlAndroid = Uri.parse(url);

    // android , web
    if (await canLaunchUrl(whatsappURlAndroid)) {
      await launchUrl(whatsappURlAndroid, mode: LaunchMode.externalApplication);
    } else {
      UIGlobal.showToast(msg: tr(context, "Can not Open whatsapp"));
    }
  }

  static textMe(context, phoneNumber) async {
    // Android
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: '$phoneNumber',
      queryParameters: <String, String>{
        'body': Uri.encodeComponent('hello%20there'),
      },
    );

    if (await canLaunchUrl(smsLaunchUri)) {
      if (Platform.isAndroid) {
        await launchUrl(smsLaunchUri);
      } else if (Platform.isIOS) {
        // iOS
        await launchUrl(smsLaunchUri);
      }
    } else {
      UIGlobal.showToast(msg: 'Could not launch ${smsLaunchUri.toString()}');
    }
  }

  static launchCaller(context, phoneNumber) async {
    final Uri callLaunchUri = Uri(scheme: 'tel', path: '$phoneNumber');

    if (await canLaunchUrl(callLaunchUri)) {
      await launchUrl(callLaunchUri);
    } else {
      UIGlobal.showToast(msg: 'Could not launch ${callLaunchUri.toString()}');
    }
  }
    static openEmail(context, String email) async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: email, queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
    } else {
      UIGlobal.showToast(msg: 'Could not launch ${emailLaunchUri.toString()}');
    }
  }
}
