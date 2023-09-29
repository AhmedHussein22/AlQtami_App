import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../entities/quran_surh.dart';

abstract class QuranSurahRepository {
  Future<Either<ServerException, AllQuranSur>> getQuranSurah();
}
