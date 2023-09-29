import 'dart:convert';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../utils/app_utils/app_strings.dart';
import '../../../../../utils/app_utils/preference.dart';
import '../../models/qoute_model.dart';

abstract class RandomQuoteLocalDataSource {
  Future<QuoteModel> getLastRandomQuote();
  Future<void> cacheQuote(QuoteModel quote);
}

class RandomQuoteLocalDataSourceImpl implements RandomQuoteLocalDataSource {

  RandomQuoteLocalDataSourceImpl();

  @override
  Future<QuoteModel> getLastRandomQuote() {
    final jsonString = Preference.getString(AppStrings.cachedRandomQuote);
    if (jsonString != null) {
      final cacheRandomQuote = Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cacheRandomQuote;
    } else {
      throw const CacheException();
    }
  }

  @override
  Future<void> cacheQuote(QuoteModel quote) {
    return Preference.setString(AppStrings.cachedRandomQuote, quote.toString());
  }
}
