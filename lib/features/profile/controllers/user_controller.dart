import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

class UserController extends ChangeNotifier {
  UserController(this._preferencesManager) {
    _loadUser();
  }

  final PreferencesManager _preferencesManager;

  String _userName = '';
  String _motivation = '';
  String _profileImage = '';

  String get userName => _userName;
  String get motivation => _motivation;
  String get profileImage => _profileImage;

  void _loadUser() {
    _userName = _preferencesManager.getUserName() ?? 'Guest';

    _motivation =
        _preferencesManager.getMotivation() ??
        'One task at a time. One step closer.';

    _profileImage = _preferencesManager.getProfileImage() ?? '';
  }

  Future<void> updateUser({
    required String newUserName,
    required String newMotivation,
  }) async {
    newUserName = newUserName.trim();
    newMotivation = newMotivation.trim();

    if (_userName == newUserName && _motivation == newMotivation) {
      return;
    }

    await _preferencesManager.saveUserName(newUserName);
    await _preferencesManager.saveMotivation(newMotivation);

    _userName = newUserName;
    _motivation = newMotivation;

    notifyListeners();
  }

  Future<void> updateProfileImage(String newImagePath) async {
    if (_profileImage == newImagePath) {
      return;
    }

    await _preferencesManager.saveProfileImage(newImagePath);

    _profileImage = newImagePath;

    notifyListeners();
  }

  Future<void> clearUserData() async {
    // There is no need for a notification if there is no change.
    final hasUserData =
        _userName.isNotEmpty ||
        _motivation.isNotEmpty ||
        _profileImage.isNotEmpty;

    if (!hasUserData) return;

    await _preferencesManager.clearUserData();

    _userName = '';
    _motivation = '';
    _profileImage = '';

    notifyListeners();
  }
}
