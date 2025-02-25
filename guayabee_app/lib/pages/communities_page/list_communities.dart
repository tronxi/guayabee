import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/models/community.dart';
import 'package:guayabee_app/pages/communities_page/community_overview.dart';

class ListCommunities extends StatelessWidget {
  final List<Community> communities;
  final List<Community> followingCommunities;

  const ListCommunities({
    super.key,
    required this.communities,
    required this.followingCommunities,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth >= 600 ? 2 : 1;
        double aspectRatio =
            constraints.maxWidth >= 900
                ? 5
                : constraints.maxWidth >= 600
                ? 4
                : 3;
        return Obx(() {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: aspectRatio,
            ),
            itemCount: communities.length,
            itemBuilder: (context, index) {
              final community = communities[index];
              return CommunityOverview(
                community: community,
                isFollowing: followingCommunities.contains(community),
              );
            },
          );
        });
      },
    );
  }
}
