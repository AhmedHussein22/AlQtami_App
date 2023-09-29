import 'package:equatable/equatable.dart';

import '../../../domain/entities/quran_surh.dart';

abstract class QuranSurState extends Equatable {
  const QuranSurState();

  @override
  List<Object> get props => [];
}

class QuranSurInitial extends QuranSurState {}

class QuranSurIsLoading extends QuranSurState {}

class QuranSurLoaded extends QuranSurState {
  final AllQuranSur allQuranSur;

  const QuranSurLoaded({required this.allQuranSur});

  @override
  List<Object> get props => [allQuranSur];
}

class QuranSurError extends QuranSurState {
  final String errormsg;

  const QuranSurError({required this.errormsg});

  @override
  List<Object> get props => [errormsg];
}
