import 'package:get/get.dart';
import 'package:guayabee_app/models/community.dart';
import 'package:guayabee_app/services/http_service.dart';

class CommunitiesController extends GetxController {
  final HttpService _httpService = Get.put(HttpService());
  RxList<Community> allCommunities = <Community>[].obs;
  RxList<Community> followingCommunities = <Community>[].obs;

  @override
  void onInit() {
    super.onInit();
    retrieveAll();
    retrieveFollowing();
  }

  void retrieveAll() async {
    allCommunities.value = await _httpService.getList(
      "/communities",
      Community.fromJson,
    );
  }

  void retrieveFollowing() async {
    followingCommunities.value = await _httpService.getList(
      "/users/communities",
      Community.fromJson,
    );
  }
}
