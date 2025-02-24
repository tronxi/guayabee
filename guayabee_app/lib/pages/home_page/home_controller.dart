import 'package:get/get.dart';
import 'package:guayabee_app/models/community.dart';
import 'package:guayabee_app/services/http_service.dart';

class HomeController extends GetxController {
  final HttpService _httpService = Get.put(HttpService());

  void retrieve() async {
    List<Community> community = await _httpService.getList(
      "/users/communities",
      Community.fromJson,
    );
    print(community);
  }
}
