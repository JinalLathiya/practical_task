import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService(this._preferences);

  final SharedPreferencesWithCache _preferences;

  Future<void> clearData() async {
    final languageCode = this.languageCode;

    await _preferences.clear();

    this.languageCode = languageCode;
  }

  String? get languageCode => _preferences.getString('language_code');

  set languageCode(String? value) {
    if (value == null) {
      _preferences.remove('language_code');
      return;
    }
    _preferences.setString('language_code', value);
  }
}
