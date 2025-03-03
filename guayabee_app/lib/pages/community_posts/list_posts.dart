import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/models/post.dart';
import 'package:guayabee_app/pages/community_posts/post_overview.dart';

class ListPosts extends StatelessWidget {
  final List<Post> posts;

  const ListPosts({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth >= 600 ? 2 : 1;
        double aspectRatio = constraints.maxWidth >= 900 ? 3 : 2;
        return Obx(() {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: aspectRatio,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostOverview(post: post);
            },
          );
        });
      },
    );
  }
}
