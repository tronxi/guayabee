import 'package:get/get.dart';
import 'package:guayabee_app/pages/community_posts/community_posts_controller.dart';

class CommunityPostsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommunityPostsController());
  }
}
