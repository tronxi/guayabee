import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/pages/communities_page/list_communities.dart';
import 'package:guayabee_app/pages/communities_page/communities_controller.dart';

class CommunitiesPage extends StatelessWidget {
  final controller = Get.find<CommunitiesController>();

  CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [Tab(text: "All Communities"), Tab(text: "Following")],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListCommunities(communities: controller.allCommunities),
                ListCommunities(communities: controller.followingCommunities),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
