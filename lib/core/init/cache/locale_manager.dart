import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static final LocaleManager _instance = LocaleManager._init();

  SharedPreferences _preferences;
  static LocaleManager get instance => _instance;

  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static Future<SharedPreferences> prefrencesInit() async {
    return instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }

  Future<void> clearString(String key) async {
    await _preferences.remove(key);
  }

  Future<void> setStringValue(String key, String value) async {
    await _preferences.setString(key, value);
  }

  Future<void> setBoolValue(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  String getStringValue(String key) => _preferences.getString(key) ?? '';

  bool getBoolValue(String key) => _preferences.getBool(key) ?? false;


 
}
