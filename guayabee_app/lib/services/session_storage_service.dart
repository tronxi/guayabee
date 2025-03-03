import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionStorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<SessionStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveProfile(Map<String, dynamic> userInfo) async {
    await _prefs.setString('given_name', userInfo['given_name'] ?? '');
    await _prefs.setString('family_name', userInfo['family_name'] ?? '');
    await _prefs.setString('email', userInfo['email'] ?? '');
  }

  Future<Map<String, String?>> getProfile() async {
    return {
      'given_name': _prefs.getString('given_name'),
      'family_name': _prefs.getString('family_name'),
      'email': _prefs.getString('email'),
    };
  }

  Future<void> removeProfile() async {
    await _prefs.remove('given_name');
    await _prefs.remove('family_name');
    await _prefs.remove('email');
  }

  Future<void> save(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<String?> get(String key) async {
    return _prefs.getString(key);
  }

}
