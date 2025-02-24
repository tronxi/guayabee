import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:guayabee_app/models/community.dart';

class ListCommunities extends StatelessWidget {
  final List<Community> communities;

  const ListCommunities({super.key, required this.communities});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: communities.length,
        itemBuilder: (context, index) {
          final community = communities[index];
          return ListTile(title: Text(community.name!));
        },
      );
    });
  }
}
