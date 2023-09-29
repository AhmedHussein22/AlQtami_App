import 'package:flutter/material.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

import '../../../../../config/locale/app_localizations.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIGlobal.appBar(context, tr(context, "about")),
      body: SingleChildScrollView(
        child: const Center(
          child: Text(
            "تطبيق ناصر القطامي\n هو عبارة عن تطبيق يجمع القران الكريم كاملاً\n ولا يعتبر هذاالتطبيق رسميا او ملكا للشيخ ناصر القطامى بل هو اجتهاد شخصى لكى يستفيد بة كل مسلم \n  ويحتوي على العديد من الخصائص الاخرى\n ويمكنكم التواصل معنا عبر البريد الالكتروني\n وشكراً",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ).allPadding(20),
      ),
    );
  }
}
