import 'package:naser_alqtami/common_widgets/click_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/assets_manager.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../config/routes/app_routes.dart';
import 'widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  List<Map<String, String>> onboardingData = const [
    {
      "text": "تطبيق القطامي تم تطويره لخدمة المستخدم المسلم للاستفادة منة",
    },
    {
      "text": "التقنيات الحديثة المتوفرة‘ تطبيق القرآن الكريم برنامج متخصص بعرض القرآن الكريم بصورة تفاعلية",
    },
    {
      "text": "تطبيق القطامي يحتوي علي العديد من الاحتياجات اليومية لكل مسلم ",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImagesPaths.bg,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            0.25.sh.verticalSpace,
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  text: onboardingData[index]['text']!,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index),
              ),
            ),
            20.verticalSpace,
            ClickButton(
              text: tr(context, "get_start"),
              onPressed: () => Navigator.pushReplacementNamed(context, Routes.mainScreen)
              // Implement navigation to the main screen here
              ,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5).r,
      height: 10.h,
      width: currentPage == index ? 20.w : 10.w,
      decoration: BoxDecoration(
        color: currentPage == index ? AppColors.White_COLOR : AppColors.KASHMIR_COLOR.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5).r,
      ),
    );
  }
}
