import 'package:naser_alqtami/common_widgets/click_btn.dart';
import 'package:flutter/material.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

import '../config/locale/app_localizations.dart';
import '../utils/app_utils/app_colors.dart';

class OnErrorWidget extends StatelessWidget {
  final String? errorMsg;
  final VoidCallback? onPress;
  const OnErrorWidget({Key? key, this.onPress, this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.DARK_BLUE_COLOR,
            size: 150,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            //"something_went_wrong",
            errorMsg ?? tr(context, 'something_went_wrong'),
            style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          //"try_again",
          tr(context, 'try_again'),
          style: context.displayMediumH2,
        ),
        Container(
          height: 55,
          // width: 100,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ClickButton(
            text: tr(context, 'reload_screen'),
            onPressed: () {
              if (onPress != null) {
                onPress!();
              }
            },
          ),
        )
      ],
    );
  }
}
