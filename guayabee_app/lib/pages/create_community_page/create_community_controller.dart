import 'package:get/get.dart';
import 'package:guayabee_app/models/community.dart';
import 'package:guayabee_app/models/create_community_order.dart';
import 'package:guayabee_app/routes.dart';
import 'package:guayabee_app/services/http_service.dart';

class CreateCommunityController extends GetxController {
  final HttpService _httpService = Get.find<HttpService>();

  var name = "".obs;
  var description = "".obs;
  var imageUrl = "".obs;

  Future<void> createCommunity() async {
    if (name.value.isEmpty) {
      Get.snackbar("Error", "Community name is required.");
      return;
    }

    try {
      final community = await _httpService.post<Community>(
        "/communities",
        CreateCommunityOrder(
          name: name.value,
          description: description.value,
          imageUrl: imageUrl.value.isNotEmpty ? imageUrl.value : "",
        ).toJson(),
        Community.fromJson,
      );
      Get.snackbar("Success", "Community '${community.name}' created!");
      Routes.change(Routes.communities);
    } catch (e) {
      Get.snackbar("Error", "Failed to create community: $e");
    }
  }
}
