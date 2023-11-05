import 'package:audio_service/audio_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/domain/repositories/quran_surah_repo.dart';
import 'package:naser_alqtami/utils/app_utils/preference.dart';

import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/network/network_info.dart';
import 'core/play_audio/player_manager/page_manager.dart';
import 'core/play_audio/services/audio_handler.dart';
import 'core/play_audio/services/playlist_repository.dart';
import 'features/audios/data/datasources/remote/download_media_remote.dart';
import 'features/audios/data/repositories/download_media_impl.dart';
import 'features/audios/domain/repositories/download_media_repo.dart';
import 'features/audios/domain/usecases/dounload_media_usecase.dart';
import 'features/audios/presentation/cubits/download_media/download_audio_cubit.dart';
import 'features/on_boarding/data/datasources/lang_local_data_source.dart';
import 'features/on_boarding/data/repositories/lang_repository_impl.dart';
import 'features/on_boarding/domain/repositories/lang_repository.dart';
import 'features/on_boarding/domain/usecases/change_lang.dart';
import 'features/on_boarding/domain/usecases/get_saved_lang.dart';
import 'features/on_boarding/presentation/bloc/locale_bloc.dart';
import 'features/random_qoute/data/data_sources/loacal/random_qoute_local.dart';
import 'features/random_qoute/data/data_sources/remote/random_qoute_remote.dart';
import 'features/random_qoute/data/reporsitories/qoute_reporsitory_impl.dart';
import 'features/random_qoute/domain/repositories/qoute_repositery.dart';
import 'features/random_qoute/domain/use_case/get_random_qoutes.dart';
import 'features/random_qoute/presentations/cubits/random_quote_cubit.dart';
import 'features/videos_and_photos_media/data/datasources/local/quran_sur_local.dart';
import 'features/videos_and_photos_media/data/repositories/quran_surah_repo_impl.dart';
import 'features/videos_and_photos_media/domain/usecases/get_quran_sur.dart';
import 'features/videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_cubit.dart';

final serviceLoctor = GetIt.instance;

Future<void> initDI() async {
  //! Features

  // Blocs
  serviceLoctor.registerFactory<RandomQuoteCubit>(() => RandomQuoteCubit(getRandomQuoteUseCase: serviceLoctor()));
  serviceLoctor.registerFactory<QuranSurCubit>(() => QuranSurCubit(getQuranSurUseCase: serviceLoctor()));
  serviceLoctor.registerFactory<LocaleCubit>(() => LocaleCubit(getSavedLangUseCase: serviceLoctor(), changeLangUseCase: serviceLoctor()));
  serviceLoctor.registerFactory<DownloadMediaCubit>(() => DownloadMediaCubit(downloadMediaUseCase: serviceLoctor()));

  // Use cases
  serviceLoctor.registerLazySingleton<GetRandomQuote>(() => GetRandomQuote(quoteRepository: serviceLoctor()));
  serviceLoctor.registerLazySingleton<GetQuranSur>(() => GetQuranSur(quranSurahRepository: serviceLoctor()));
  serviceLoctor.registerLazySingleton<GetDownloadMedia>(() => GetDownloadMedia(downloadMediaRepository: serviceLoctor()));

  serviceLoctor.registerLazySingleton<GetSavedLangUseCase>(() => GetSavedLangUseCase(langRepository: serviceLoctor()));
  serviceLoctor.registerLazySingleton<ChangeLangUseCase>(() => ChangeLangUseCase(langRepository: serviceLoctor()));

  // Repository
  serviceLoctor
      .registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(networkInfo: serviceLoctor(), randomQuoteRemoteDataSource: serviceLoctor(), randomQuoteLocalDataSource: serviceLoctor()));
  serviceLoctor.registerLazySingleton<QuranSurahRepository>(() => QuranSurRepositoryImpl(networkInfo: serviceLoctor(), quranSurLocalDataSource: serviceLoctor()));
  serviceLoctor.registerLazySingleton<DownloadMediaRepository>(() => DownloadMediaRepositoryImpl(networkInfo: serviceLoctor(), downloadMediaRemoteDataSource: serviceLoctor()));

  serviceLoctor.registerLazySingleton<LangRepository>(() => LangRepositoryImpl(langLocalDataSource: serviceLoctor()));
  serviceLoctor.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // Data Sources
  serviceLoctor.registerLazySingleton<RandomQuoteLocalDataSource>(() => RandomQuoteLocalDataSourceImpl());
  serviceLoctor.registerLazySingleton<RandomQuoteRemoteDataSource>(() => RandomQuoteRemoteDataSourceImpl(apiConsumer: serviceLoctor()));
  serviceLoctor.registerLazySingleton<DownloadMediaRemoteDataSource>(() => DownloadMediaRemoteDataSourceImpl(apiConsumer: serviceLoctor()));

  serviceLoctor.registerLazySingleton<QuranSurLocalDataSource>(() => QuranSurLocalDataSourceImpl());

  serviceLoctor.registerLazySingleton<LangLocalDataSource>(() => LangLocalDataSourceImpl());

  //! Core
  serviceLoctor.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker: serviceLoctor()));
  serviceLoctor.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: serviceLoctor()));
  serviceLoctor.registerLazySingleton<PageManager>(() => PageManager());
  serviceLoctor.registerSingleton<AudioHandler>(await initAudioService());

  //! External
  await Preference.init();
  serviceLoctor.registerLazySingleton(() => Preference.sb);
  serviceLoctor.registerLazySingleton(() => AppIntercepters());
  serviceLoctor.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
  serviceLoctor.registerLazySingleton(() => InternetConnectionChecker());
  serviceLoctor.registerLazySingleton(() => Dio());
}
