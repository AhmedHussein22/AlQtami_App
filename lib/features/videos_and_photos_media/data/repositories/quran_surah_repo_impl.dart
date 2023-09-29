import 'package:dartz/dartz.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/domain/repositories/quran_surah_repo.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/quran_surh.dart';
import '../datasources/local/quran_sur_local.dart';


class QuranSurRepositoryImpl implements QuranSurahRepository {
  final NetworkInfo networkInfo;
  final QuranSurLocalDataSource quranSurLocalDataSource;

  QuranSurRepositoryImpl({required this.networkInfo, required
    this.quranSurLocalDataSource,
  });

  @override
  Future<Either<ServerException, AllQuranSur>> getQuranSurah() async {
    // if (await networkInfo.isConnected) {
    try {
      final remoteRandomQuote = await quranSurLocalDataSource.getQuranSur();
      return Right(remoteRandomQuote);
    } on ServerException catch (e) {
      return Left(e);
    }
  }

  //   else {
  //     try {
  //       final cacheRandomQuote =
  //           await randomQuoteLocalDataSource.getLastRandomQuote();
  //       return Right(cacheRandomQuote);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }
}
