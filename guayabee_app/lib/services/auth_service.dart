import 'package:get/get.dart';
import 'package:guayabee_app/services/secure_storage_service.dart';
import 'package:guayabee_app/services/session_storage_service.dart';

class AuthService extends GetxService {
  RxBool isLoggedIn = false.obs;

  final SecureStorageService _secureStorageService = Get.put(
    SecureStorageService(),
  );

  late final SessionStorageService _sessionStorageService;

  Future<AuthService> init() async {
    _sessionStorageService = await Get.putAsync(
      () => SessionStorageService().init(),
    );
    String? token = await _secureStorageService.get("accessToken");
    isLoggedIn.value = token != null;
    return this;
  }

  Future<void> loginWithUserInfo(
    String accessToken,
    String? refreshToken,
    Map<String, dynamic> userInfo,
  ) async {
    _sessionStorageService.saveProfile(userInfo);
    await login(accessToken, refreshToken);
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
    await _sessionStorageService.removeProfile();
    isLoggedIn.value = false;
  }

  Future<String?> getAccessToken() {
    return _secureStorageService.get("accessToken");
  }

  Future<String?> getRefreshToken() {
    return _secureStorageService.get("refreshToken");
  }
}
