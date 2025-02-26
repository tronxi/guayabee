import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/pages/communities_page/list_communities.dart';
import 'package:guayabee_app/pages/communities_page/communities_controller.dart';
import 'package:guayabee_app/routes.dart';
import 'package:guayabee_app/services/auth_service.dart';

class CommunitiesPage extends StatelessWidget {
  final controller = Get.find<CommunitiesController>();
  final authService = Get.find<AuthService>();

  CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Routes.change(Routes.createCommunity);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: DefaultTabController(
        length: authService.isLoggedIn.value ? 2 : 1,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: "All Communities"),
                if (authService.isLoggedIn.value) Tab(text: "Following"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListCommunities(
                    communities: controller.allCommunities,
                    followingCommunities: controller.followingCommunities,
                  ),
                  if (authService.isLoggedIn.value)
                    ListCommunities(
                      communities: controller.followingCommunities,
                      followingCommunities: controller.followingCommunities,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
