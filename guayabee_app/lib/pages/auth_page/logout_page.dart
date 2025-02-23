import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/services/auth_service.dart';

class LogoutPage extends StatefulWidget {
  final void Function() onLogout;

  const LogoutPage({super.key, required this.onLogout});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  late final AuthService _authService;

  @override
  void initState() {
    _authService = Get.put(AuthService());
    _authService.logout().then((_) {
      widget.onLogout();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
