import 'package:get/get.dart';
import 'package:guayabee_app/pages/communities_page/communities_controller.dart';

class CommunitiesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunitiesController());
  }
}
