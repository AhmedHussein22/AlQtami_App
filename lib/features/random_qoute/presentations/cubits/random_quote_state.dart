import 'package:equatable/equatable.dart';
import 'package:naser_alqtami/features/random_qoute/domain/entities/qoutes.dart';

abstract class RandomQuoteState extends Equatable {
  const RandomQuoteState();

  @override
  List<Object> get props => [];
}

class RandomQuoteInitial extends RandomQuoteState {}

class RandomQuoteIsLoading extends RandomQuoteState {}

class RandomQuoteLoaded extends RandomQuoteState {
  final Qoutes quote;

  const RandomQuoteLoaded({required this.quote});

  @override
  List<Object> get props => [quote];
}

class RandomQuoteError extends RandomQuoteState {
  final String errormsg;

  const RandomQuoteError({required this.errormsg});

  @override
  List<Object> get props => [errormsg];
}
