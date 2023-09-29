import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naser_alqtami/features/videos_and_photos_media/presentation/cubits/quran_sur/quran_sur_state.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/entities/quran_surh.dart';
import '../../../domain/usecases/get_quran_sur.dart';

class QuranSurCubit extends Cubit<QuranSurState> {
  final GetQuranSur getQuranSurUseCase;
  QuranSurCubit({required this.getQuranSurUseCase}) : super(QuranSurInitial());
  AllQuranSur? quranSur;
  Future<void> getQuranSur() async {
    emit(QuranSurIsLoading());
    Either<ServerException, AllQuranSur> response = await getQuranSurUseCase(NoParams());
    emit(response.fold((failure) {
      return QuranSurError(errormsg: failure.message);
    }, (allQuranSur) {
     
      quranSur = allQuranSur;
      return QuranSurLoaded(allQuranSur: allQuranSur);
    }));
  }
}
