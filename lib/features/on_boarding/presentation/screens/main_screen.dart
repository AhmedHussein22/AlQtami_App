// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naser_alqtami/config/locale/app_localizations.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/settings/settings.dart';
import 'package:naser_alqtami/features/downloads/presentation/screens/downloads.dart';
import 'package:naser_alqtami/features/favorites/presentation/screens/favorites.dart';
import 'package:naser_alqtami/features/on_boarding/presentation/screens/home_screen.dart';
import 'package:naser_alqtami/utils/app_utils/app_colors.dart';
import 'package:naser_alqtami/utils/app_utils/extentions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> customerScreens = const [HomeScreen(), Favorites(), Downloads(), Settings()];

  @override
  Widget build(BuildContext context) {
    //MainProvider mainProvider = Provider.of(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.KASHMIR_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          margin: 8.vPadding + 8.hPadding,
          padding: 5.vPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //************ frist item ********** */
              buildNavItem(Icons.home, tr(context, "home"), 0),
              buildNavItem(CupertinoIcons.heart_fill, tr(context, "favorites"), 1),
              buildNavItem(CupertinoIcons.arrow_down_to_line, tr(context, "library"), 2),
              buildNavItem(CupertinoIcons.settings, tr(context, "setting"), 3),
            ],
          ),
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: customerScreens,
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.White_COLOR,
          ),
          if (_selectedIndex == index) Text(text, style: const TextStyle(color: AppColors.White_COLOR, fontSize: 12)),
        ],
      ),
    );
  }
}
