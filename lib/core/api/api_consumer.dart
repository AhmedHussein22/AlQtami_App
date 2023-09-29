
abstract class ApiConsumer {

  Future<dynamic> request(
    String path,
    String? requestType, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  });

  Future<dynamic> downloadAndSaveFile(
    String path,
    String fileName );
}
