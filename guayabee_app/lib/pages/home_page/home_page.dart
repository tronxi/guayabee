import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/pages/home_page/home_controller.dart';
import 'package:guayabee_app/widgets/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return CustomScaffold(body: Text("hola"));
      },
    );
  }
}
