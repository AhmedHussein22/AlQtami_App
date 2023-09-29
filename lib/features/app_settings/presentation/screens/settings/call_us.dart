import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/widgets/custom_continer.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/widgets/icon_of_call_us.dart';
import 'package:naser_alqtami/utils/app_utils/assets_manager.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

import '../../../../../config/locale/app_localizations.dart';
import '../../../../../utils/app_utils/app_globals.dart';

class CallUs extends StatelessWidget {
  const CallUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIGlobal.appBar(context, tr(context, "callus")),
      //bottomNavigationBar: CustemBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 80.r,
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage(ImagesPaths.logoWithoutBG),
            ),
            const Text(
              "Ahmed Hussien",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Flutter Developer",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              height: 50,
              thickness: 10,
              color: Colors.blueGrey.withOpacity(0.3),
              indent: 20,
              endIndent: 20,
            ),
            CustomContainer(
              icon: FontAwesomeIcons.phone,
              iconColor: Colors.green,
              text: 'Call Us',
              onTap: () => AppGloabl.launchCaller(context, '01114484229'),
            ),
            CustomContainer(
              icon: Icons.email,
              iconColor: Colors.green,
              text: 'Gmail',
              onTap: () => AppGloabl.openEmail(context, 'mrCode.dev22@gmail.com'),
            ).vPadding(10),
            CustomContainer(
              icon: FontAwesomeIcons.squareWhatsapp,
              iconColor: Colors.green,
              text: 'WhatsApp',
              onTap: () => AppGloabl.openWhatsapp(context, '01114484229'),
            ),
            const CallUsIcons().vPadding(20),
          ],
        ).hPadding(20),
      ),
    );
  }
}
