import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';

abstract class DownloadMediaRepository {
  Future<Either<ServerException, String>> downloadMedia({required String path, required String fileName});
}
