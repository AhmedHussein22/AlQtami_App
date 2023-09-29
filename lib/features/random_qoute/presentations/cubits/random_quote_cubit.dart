import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naser_alqtami/features/random_qoute/domain/entities/qoutes.dart';
import 'package:naser_alqtami/features/random_qoute/presentations/cubits/random_quote_state.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/use_case/get_random_qoutes.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase}) : super(RandomQuoteInitial());

  Future<void> getRandomQuote() async {
    emit(RandomQuoteIsLoading());
    Either<ServerException, Qoutes> response = await getRandomQuoteUseCase(NoParams());
    emit(response.fold((failure) {
      return RandomQuoteError(errormsg: failure.message);
    }, (quote) => RandomQuoteLoaded(quote: quote)));
  }
}
