import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/download_media_repo.dart';

class GetDownloadMedia implements UseCase<String, Params> {
  DownloadMediaRepository downloadMediaRepository;
  GetDownloadMedia({required this.downloadMediaRepository});
  @override
  Future<Either<ServerException, String>> call(Params params) {
    return downloadMediaRepository.downloadMedia(fileName: params.fileName, path: params.path);
  }
}

class Params extends Equatable {
  final String path;
  final String fileName;

  const Params({required this.path, required this.fileName});
  @override
  List<Object?> get props => [path, fileName];
}
