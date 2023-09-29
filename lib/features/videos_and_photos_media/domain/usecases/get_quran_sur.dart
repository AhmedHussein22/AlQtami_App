import 'package:dartz/dartz.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/domain/repositories/quran_surah_repo.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/quran_surh.dart';

class GetQuranSur implements UseCase<AllQuranSur, NoParams> {
  QuranSurahRepository quranSurahRepository;
  GetQuranSur({required this.quranSurahRepository});
  @override
  Future<Either<ServerException, AllQuranSur>> call(NoParams params) {
    return quranSurahRepository.getQuranSurah();
  }
}
