import 'package:flutter/material.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/settings/appout_us.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/settings/call_us.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/settings/priviacy.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/settings/settings.dart';
import 'package:naser_alqtami/features/app_settings/presentation/screens/settings/terms.dart';
import 'package:naser_alqtami/features/audios/presentation/screens/quran_radio.dart';
import 'package:naser_alqtami/features/downloads/presentation/screens/downloads.dart';
import 'package:naser_alqtami/features/favorites/presentation/screens/favorites.dart';
import 'package:naser_alqtami/features/on_boarding/presentation/screens/home_screen.dart';
import 'package:naser_alqtami/features/on_boarding/presentation/screens/main_screen.dart';
import 'package:naser_alqtami/features/on_boarding/presentation/screens/on_boarding.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/presentation/screens/quran_live.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/presentation/screens/quran_photos.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/presentation/screens/quran_video.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/presentation/widgets/quran_photos/google_photos.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/presentation/widgets/quran_video/play_youtube_video.dart';

import '../../features/audios/presentation/screens/quran_audio.dart';
import '../../features/on_boarding/presentation/screens/splash_screen.dart';
import '../../utils/app_utils/app_strings.dart';

class Routes {
  static const String initialRoute = '/';
  static const String homeScreenRoute = '/homeScreen';
  static const String onBoardingRoute = '/onBoarding';
  static const String quranvideoRoute = '/quranvideo';
  static const String playYouTubeVideoRoute = '/PlayYouTubeVideo';
  static const String quranAudio = '/quranAudio';
  static const String quranLive = '/QuranLive';
  static const String quranRadio = '/QuranRadio';
  static const String quranPhotos = '/QuranPhotos';
  static const String shortVideos = '/ShortVideos';
  static const String favorites = '/favorites';
  static const String downloads = '/Downloads';
  static const String settings = '/Settings';
  static const String callUs = '/CallUs';
  static const String aboutUs = '/aboutUs';
  static const String trems = '/trems';
  static const String privacy = '/privacy';
  static const String mainScreen = '/mainScreen';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSetting) {
    switch (routeSetting.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());
      case Routes.homeScreenRoute:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.quranvideoRoute:
        return MaterialPageRoute(builder: (context) => const Quranvideo());
      case Routes.playYouTubeVideoRoute:
        return MaterialPageRoute(builder: (context) => PlayYouTubeVideo(index: routeSetting.arguments as int));
      case Routes.quranAudio:
        return MaterialPageRoute(builder: (context) => const QuranAudio());
      case Routes.quranLive:
        return MaterialPageRoute(builder: (context) => const QuranLive());
      case Routes.quranRadio:
        return MaterialPageRoute(builder: (context) => const QuranRadio());
      case Routes.quranPhotos:
        return MaterialPageRoute(builder: (context) => const QuranPhotos());
      case Routes.shortVideos:
        return MaterialPageRoute(builder: (context) => const GooglePhotos());
      case Routes.favorites:
        return MaterialPageRoute(builder: (context) => const Favorites());
      case Routes.downloads:
        return MaterialPageRoute(builder: (context) => const Downloads());
      case Routes.settings:
        return MaterialPageRoute(builder: (context) => const Settings());
      case Routes.callUs:
        return MaterialPageRoute(builder: (context) => const CallUs());
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case Routes.aboutUs:
        return MaterialPageRoute(builder: (context) => const AboutUS());
      case Routes.trems:
        return MaterialPageRoute(builder: (context) => const Terms());
      case Routes.privacy:
        return MaterialPageRoute(builder: (context) => const Privacy());

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
