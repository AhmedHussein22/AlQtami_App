import 'package:naser_alqtami/utils/app_utils/preference.dart';

abstract class LangLocalDataSource {
  Future<bool> changeLang({required String langCode});
  Future<String> getSavedLang();
}

class LangLocalDataSourceImpl implements LangLocalDataSource {
  LangLocalDataSourceImpl();
  @override
  Future<bool> changeLang({required String langCode}) async => await Preference.setString(PrefKeys.appLanguage, langCode);

  @override
  Future<String> getSavedLang() async => Preference.getString(PrefKeys.appLanguage) ?? PrefKeys.englishCode;
}
