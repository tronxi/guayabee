import 'package:get/get.dart';
import 'package:guayabee_app/models/community.dart';
import 'package:guayabee_app/services/auth_service.dart';
import 'package:guayabee_app/services/http_service.dart';

class CommunitiesController extends GetxController {
  final HttpService _httpService = Get.put(HttpService());
  final AuthService _authService = Get.put(AuthService());
  RxList<Community> allCommunities = <Community>[].obs;
  RxList<Community> followingCommunities = <Community>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initRetrieve();
  }

  void _initRetrieve() async {
    if (_authService.isLoggedIn.value) {
      await retrieveFollowing();
    }
    retrieveAll();
  }

  Future<void> retrieveAll() async {
    allCommunities.value = await _httpService.getList(
      "/communities",
      Community.fromJson,
    );
  }

  Future<void> retrieveFollowing() async {
    followingCommunities.value = await _httpService.getList(
      "/users/communities",
      Community.fromJson,
    );
  }

  void join(Community community) async {
    await _httpService
        .put("/users/communities/${community.id}", {}, (_) => {})
        .then((_) => _initRetrieve());
  }

  void leave(Community community) async {
    await _httpService
        .delete("/users/communities/${community.id}", (_) => {})
        .then((_) => _initRetrieve());
  }
}
