import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/pages/community_posts/list_posts.dart';

import 'community_posts_controller.dart';

class CommunityPostsPage extends StatefulWidget {
  const CommunityPostsPage({super.key});

  @override
  State<CommunityPostsPage> createState() => _CommunityPostsPageState();
}

class _CommunityPostsPageState extends State<CommunityPostsPage> {
  final controller = Get.find<CommunityPostsController>();
  late final String communityName;

  @override
  void initState() {
    String? communityId = Get.parameters['communityId'];
    communityName = Get.parameters['communityName'] ?? "";
    controller.retrievePosts(communityId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Text(
            communityName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
          Expanded(child: ListPosts(posts: controller.posts)),
        ],
      ),
    );
  }
}
