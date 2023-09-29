import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:naser_alqtami/utils/app_utils/app_strings.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../app_utils/app_colors.dart';

class UIGlobal {
  static void showErrorDialog({required BuildContext context, required String msg}) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          msg,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  static PreferredSize appBar(BuildContext context, String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        title: Text(
          title,
          style: context.displayMediumH2,
        ),
      ),
    );
  }

  static void showToast({required String msg, Color? color, ToastGravity? gravity}) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
      backgroundColor: color ?? AppColors.DARK_BLUE_COLOR,
      gravity: gravity ?? ToastGravity.BOTTOM,
    );
  }

  static iPhoneLoading(BuildContext context, {Color? color, size = 25.0}) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color ?? AppColors.DARK_BLUE_COLOR,
        radius: size,
      ),
    );
  }

  static showCupertinoActionSheet(BuildContext context, Widget actions) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(AppStrings.appName),
        actions: <Widget>[
          actions,
         
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
