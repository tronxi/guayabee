import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureStorageService extends GetxService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String> getOrDefault(String key, String defaultValue) async {
    return await _storage.read(key: key) ?? defaultValue;
  }

  Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> put(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }
}
