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

  Future<void> login(String accessToken) async {
    _secureStorageService.put("accessToken", accessToken).then((_) {
      isLoggedIn.value = true;
    });
  }

  Future<void> logout() async {
    _secureStorageService.remove("accessToken").then((_) {
      isLoggedIn.value = false;
    });
  }
}
