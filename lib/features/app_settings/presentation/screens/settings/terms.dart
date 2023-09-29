import 'package:flutter/material.dart';
import 'package:naser_alqtami/utils/ui_utils/ui_globals.dart';

import '../../../../../config/locale/app_localizations.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIGlobal.appBar(context, tr(context, "terms")),
      body: const SingleChildScrollView(
        child: Center(
          child: Text("About US"),
        ),
      ),
    );
  }
}
