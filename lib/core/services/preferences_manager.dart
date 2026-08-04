import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  // Keys used to store data in SharedPreferences.
  static const _userNameKey = 'userName';
  static const _motivationKey = 'motivation';
  static const _tasksKey = 'tasks';
  static const _themeKey = 'isDarkMode';
  static const _profileImageKey = 'profileImage';

  // Private constructor.
  PreferencesManager._internal();

  // The only instance that will exist during the app lifetime.
  static final PreferencesManager _instance = PreferencesManager._internal();

  // Factory constructor =>
  // Always returns the same instance (Singleton).
  factory PreferencesManager() => _instance;

  // Holds the SharedPreferences object after initialization.
  late final SharedPreferences _preferences;

  // Must be called once when the app starts.
  // Gets the SharedPreferences instance from the device.
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Returns the saved username.
  String? getUserName() {
    return _preferences.getString(_userNameKey);
  }

  // Saves the username locally.
  Future<void> saveUserName(String userName) async {
    await _preferences.setString(_userNameKey, userName);
  }

  // Returns the saved motivation quote.
  String? getMotivation() {
    return _preferences.getString(_motivationKey);
  }

  // Saves the motivation quote locally.
  Future<void> saveMotivation(String motivation) async {
    await _preferences.setString(_motivationKey, motivation);
  }

  // Saves all tasks as a JSON string.
  Future<void> saveTasks(String taskJson) async {
    await _preferences.setString(_tasksKey, taskJson);
  }

  // Returns the saved tasks JSON string.
  String? getTasks() {
    return _preferences.getString(_tasksKey);
  }

  // Removes all user related data from local storage.
  Future<void> clearUserData() async {
    await _preferences.remove(_userNameKey);
    await _preferences.remove(_motivationKey);
    await _preferences.remove(_tasksKey);
  }

  Future<void> saveTheme(bool isDark) async {
    await _preferences.setBool(_themeKey, isDark);
  }

  bool getTheme() {
    return _preferences.getBool(_themeKey) ?? true;
  }

  Future<void> saveProfileImage(String imagePath) async {
    await _preferences.setString(_profileImageKey, imagePath);
  }

  String? getProfileImage() {
    return _preferences.getString(_profileImageKey);
  }
}
