import 'package:equatable/equatable.dart';

abstract class DownloadMediaState extends Equatable {
  const DownloadMediaState();

  @override
  List<Object> get props => [];
}

class DownloadMediaInitial extends DownloadMediaState {}

class DownloadMediaIsLoading extends DownloadMediaState {}

class DownloadMediaComplete extends DownloadMediaState {
  final String filePath;

  const DownloadMediaComplete({required this.filePath});

  @override
  List<Object> get props => [filePath];
}

class DownloadMediaError extends DownloadMediaState {
  final String errormsg;

  const DownloadMediaError({required this.errormsg});

  @override
  List<Object> get props => [errormsg];
}
