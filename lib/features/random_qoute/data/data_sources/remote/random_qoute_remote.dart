import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/api/end_points.dart';
import '../../../../../core/api/request_type.dart';
import '../../models/qoute_model.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  ApiConsumer apiConsumer;

  RandomQuoteRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.request(EndPoints.randomQuote, RequestType.get);
    return QuoteModel.fromJson(response);
  }
}
