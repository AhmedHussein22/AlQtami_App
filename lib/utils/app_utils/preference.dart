import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const String fristTime = 'Frist_Time';
  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
  static const String appLanguage = 'AppLang';
  static const String favoriteSurList = 'favorite_sur_list';
  static const String downloadSurList = 'download_sur_list';
  static const String downloadSurListPaths = 'download_sur_list_Paths';
    static const String favoriteImageIDs = 'favorite_Image_IDs';
  static const String downloadImageIDs = 'download_Image_IDs';
}

class Preference {
  Preference._internal();
  static late final SharedPreferences sb;
  static Future<void> init() async {
    sb = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    return sb.getString(key);
  }

  static int? getInt(String key) {
    return sb.getInt(key);
  }

  static bool? getBool(String key) {
    return sb.getBool(key);
  }

  static Future<Set<String>?> getStringList(String key) async {
    return sb.getStringList(key)?.toSet() ?? {};
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    return sb.setStringList(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    return sb.setString(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    return sb.setInt(key, value);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await sb.setBool(key, value);
  }

  static Future<bool> remove(String key) async {
    return await sb.remove(key);
  }

  static Future<bool> clear() async {
    return await sb.clear();
  }
}
