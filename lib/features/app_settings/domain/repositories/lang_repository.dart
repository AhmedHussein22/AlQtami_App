import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';

abstract class LangRepository {
  Future<Either<ServerException, bool>> changeLang({required String langCode});
  Future<Either<ServerException, String>> getSavedLang();
}
