import '../../../../../core/api/api_consumer.dart';

abstract class DownloadMediaRemoteDataSource {
  Future<String> downloadMedia({required String path, required String fileName});
}

class DownloadMediaRemoteDataSourceImpl implements DownloadMediaRemoteDataSource {
  ApiConsumer apiConsumer;

  DownloadMediaRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> downloadMedia({required String path, required String fileName}) async {
    final response = await apiConsumer.downloadAndSaveFile(path, fileName);
    return response;
  }
}
