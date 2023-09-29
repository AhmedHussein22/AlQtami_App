import 'package:dartz/dartz.dart';
import 'package:naser_alqtami/features/random_qoute/domain/entities/qoutes.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/qoute_repositery.dart';
import '../data_sources/loacal/random_qoute_local.dart';
import '../data_sources/remote/random_qoute_remote.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;

  QuoteRepositoryImpl({required this.networkInfo, required this.randomQuoteRemoteDataSource, required this.randomQuoteLocalDataSource});

  @override
  Future<Either<ServerException, Qoutes>> getRandomQuote() async {
    // if (await networkInfo.isConnected) {
    try {
      final remoteRandomQuote = await randomQuoteRemoteDataSource.getRandomQuote();
      randomQuoteLocalDataSource.cacheQuote(remoteRandomQuote);
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
