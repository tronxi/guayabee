import 'package:get/get.dart';
import 'package:guayabee_app/models/post.dart';
import 'package:guayabee_app/services/http_service.dart';

class CommunityPostsController extends GetxController {
  final HttpService _httpService = Get.put(HttpService());

  RxList<Post> posts = <Post>[].obs;

  Future<void> retrievePosts(String? communityId) async {
    posts.value = await _httpService.getList(
      "/communities/$communityId/posts",
      Post.fromJson,
    );
  }
}
