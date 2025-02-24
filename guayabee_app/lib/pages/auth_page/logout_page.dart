import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/components/scaffold/custom_scaffold_controller.dart';
import 'package:guayabee_app/routes.dart';
import 'package:guayabee_app/services/auth_service.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  late final AuthService _authService;
  final CustomScaffoldController _customScaffoldController = Get.put(
    CustomScaffoldController(),
  );

  @override
  void initState() {
    _authService = Get.find<AuthService>();
    _authService.logout().then((_) {
      _customScaffoldController.changeIndex(0);
      Routes.change(Routes.homeRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
