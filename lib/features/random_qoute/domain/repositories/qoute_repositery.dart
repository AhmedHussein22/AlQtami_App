import 'package:dartz/dartz.dart';
import 'package:naser_alqtami/features/random_qoute/domain/entities/qoutes.dart';

import '../../../../core/errors/exceptions.dart';

abstract class QuoteRepository {
  Future<Either<ServerException, Qoutes>> getRandomQuote();
}
