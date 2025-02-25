import 'package:get/get.dart';
import 'package:guayabee_app/pages/create_community_page/create_community_controller.dart';

class CreateCommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateCommunityController());
  }
}
