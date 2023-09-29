import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naser_alqtami/core/api/dynamic_link.dart';
import 'package:naser_alqtami/utils/app_utils/app_globals.dart';

import 'config/locale/app_localizations_setup.dart';
import 'config/routes/app_routes.dart';
import 'config/theme/app_theme.dart';
import 'core/play_audio/player_manager/page_manager.dart';
import 'features/audios/presentation/cubits/download_media/download_audio_cubit.dart';
import 'features/on_boarding/presentation/bloc/locale_bloc.dart';
import 'features/on_boarding/presentation/bloc/locale_state.dart';
import 'features/videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';
import 'injection_container.dart';
import 'utils/app_utils/app_strings.dart';

class QuoteApp extends StatefulWidget {
  const QuoteApp({Key? key}) : super(key: key);

  @override
  State<QuoteApp> createState() => _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  @override
  void initState() {
    super.initState();
    serviceLoctor<PageManager>().init();
    DynamicLinkHelper().initDynamicLinksListener(context);
  }

  @override
  void dispose() {
    serviceLoctor<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => serviceLoctor<LocaleCubit>()..getSavedLang()),
          BlocProvider(create: (context) => serviceLoctor<QuranSurCubit>()..getQuranSur()),
          BlocProvider(create: (context) => serviceLoctor<DownloadMediaCubit>()),
        ],
        child: BlocBuilder<LocaleCubit, LocaleState>(
          buildWhen: (previousState, currentState) {
            return previousState != currentState;
          },
          builder: (context, state) {
            return ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                    title: AppStrings.appName,
                    navigatorKey: AppGloabl.navKey,
                    locale: state.locale,
                    // locale: const Locale("ar"),
                    debugShowCheckedModeBanner: false,
                    theme: appTheme(),
                    onGenerateRoute: AppRoutes.onGenerateRoute,
                    supportedLocales: AppLocalizationsSetup.supportedLocales,
                    localeResolutionCallback: AppLocalizationsSetup.localeResolutionCallback,
                    localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
                  );
                });
          },
        ));
  }
}
