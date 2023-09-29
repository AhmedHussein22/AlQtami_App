import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../domain/usecases/dounload_media_usecase.dart';
import 'download_audio_state.dart';

class DownloadMediaCubit extends Cubit<DownloadMediaState> {
  final GetDownloadMedia downloadMediaUseCase;
  DownloadMediaCubit({required this.downloadMediaUseCase}) : super(DownloadMediaInitial());

  Future<void> downloadMedia({required String fileName, required String path}) async {
    emit(DownloadMediaIsLoading());
    Either<ServerException, String> response = await downloadMediaUseCase.call(Params(path: path, fileName: fileName));
    emit(response.fold((failure) {
      return DownloadMediaError(errormsg: failure.message);
    }, (path) => DownloadMediaComplete(filePath: path)));
  }
}
