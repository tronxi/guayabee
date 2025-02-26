import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/models/community.dart';
import 'package:guayabee_app/pages/communities_page/communities_controller.dart';

class CommunityOverview extends StatelessWidget {
  final Community community;
  final bool isFollowing;
  final controller = Get.find<CommunitiesController>();

  CommunityOverview({
    super.key,
    required this.community,
    required this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          highlightColor: Colors.transparent,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  community.imageUrl != null && community.imageUrl!.isNotEmpty
                      ? Image.network(
                        community.imageUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                      )
                      : const Icon(Icons.group, size: 50, color: Colors.blue),
            ),
            title: Text(
              community.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              community.description ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: ElevatedButton(
              onPressed: _onJoinPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isFollowing
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
              child: Text(isFollowing ? "Unfollow" : "Follow"),
            ),
          ),
        ),
      ),
    );
  }

  void _onJoinPressed() {
    if (isFollowing) {
      controller.leave(community);
    } else {
      controller.join(community);
    }
  }
}
