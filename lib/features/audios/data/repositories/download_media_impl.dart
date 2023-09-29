import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/download_media_repo.dart';
import '../datasources/remote/download_media_remote.dart';

class DownloadMediaRepositoryImpl implements DownloadMediaRepository {
  final NetworkInfo networkInfo;
  final DownloadMediaRemoteDataSource downloadMediaRemoteDataSource;

  DownloadMediaRepositoryImpl({required this.networkInfo, required this.downloadMediaRemoteDataSource});

  @override
  Future<Either<ServerException, String>> downloadMedia({required String path, required String fileName}) async {
    // if (await networkInfo.isConnected) {
    try {
      final remoteDownloadMedia = await downloadMediaRemoteDataSource.downloadMedia(fileName: fileName, path: path);
      return Right(remoteDownloadMedia);
    } on ServerException catch (e) {
      return Left(e);
    }
  }

  //   else {
  //     try {
  //       final cacheDownloadMedia =
  //           await DownloadMediaLocalDataSource.getLastDownloadMedia();
  //       return Right(cacheDownloadMedia);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }
}
