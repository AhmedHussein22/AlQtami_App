import 'package:dartz/dartz.dart';
import 'package:naser_alqtami/features/random_qoute/domain/repositories/qoute_repositery.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/qoutes.dart';

class GetRandomQuote implements UseCase<Qoutes, NoParams> {
  QuoteRepository quoteRepository;
  GetRandomQuote({required this.quoteRepository});
  @override
  Future<Either<ServerException, Qoutes>> call(NoParams params) {
    return quoteRepository.getRandomQuote();
  }
}
