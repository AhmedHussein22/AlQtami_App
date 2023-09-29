import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

class OnboardingContent extends StatelessWidget {
  final String text;

  const OnboardingContent({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr(context, "Alqutami"),
          style: context.displayLargeH1,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 0.04.sh,
        ),
        Text(
          text,
          style: context.displayMediumH2,
          textAlign: TextAlign.center,
          //maxLines: 5,
        ).hPadding(4),
      ],
    );
  }
}
