import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/pages/create_community_page/create_community_controller.dart';

class CreateCommunityPage extends StatelessWidget {
  final CreateCommunityController controller = Get.put(
    CreateCommunityController(),
  );

  CreateCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Community")),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Community Name",
                  ),
                  onChanged: (value) => controller.name.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(labelText: "Description"),
                  onChanged: (value) => controller.description.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Image URL (optional)",
                  ),
                  onChanged: (value) => controller.imageUrl.value = value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.createCommunity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Create",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
