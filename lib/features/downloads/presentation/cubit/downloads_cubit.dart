import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'downloads_state.dart';

class DownloadsCubit extends Cubit<DownloadsState> {
  DownloadsCubit() : super(DownloadsInitial());
}
