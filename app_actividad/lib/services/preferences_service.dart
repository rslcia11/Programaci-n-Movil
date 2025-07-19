import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const THEME_KEY = 'theme';
  static const LANGUAGE_KEY = 'language';

  Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_KEY, isDark);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_KEY) ?? false;
  }

  Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_KEY, language);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LANGUAGE_KEY) ?? 'es';
  }
}
