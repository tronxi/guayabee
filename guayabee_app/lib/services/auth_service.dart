import 'package:get/get.dart';
import 'package:guayabee_app/services/secure_storage_service.dart';

class AuthService extends GetxService {
  RxBool isLoggedIn = false.obs;

  final SecureStorageService _secureStorageService = Get.put(
    SecureStorageService(),
  );

  Future<AuthService> init() async {
    String? token = await _secureStorageService.get("accessToken");
    isLoggedIn.value = token != null;
    return this;
  }

  Future<void> login(String accessToken, String? refreshToken) async {
    if (refreshToken != null) {
      await _secureStorageService.put("refreshToken", refreshToken);
    }
    await _secureStorageService.put("accessToken", accessToken);
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await _secureStorageService.remove("refreshToken");
    await _secureStorageService.remove("accessToken");
    isLoggedIn.value = false;
  }

  Future<String?> getAccessToken() {
    return _secureStorageService.get("accessToken");
  }

  Future<String?> getRefreshToken() {
    return _secureStorageService.get("refreshToken");
  }
}
