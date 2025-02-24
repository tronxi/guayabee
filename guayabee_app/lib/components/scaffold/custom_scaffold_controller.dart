import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/routes.dart';
import 'package:guayabee_app/services/auth_service.dart';

import 'menu_item.dart';

class CustomScaffoldController extends GetxController {
  var selectedIndex = 0.obs;
  final RxList<MenuItem> items = <MenuItem>[].obs;
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _updateMenuItems(_authService.isLoggedIn.value);
    _authService.isLoggedIn.listen((value) {
      _updateMenuItems(value);
    });
  }

  void _updateMenuItems(bool isLoggedIn) {
    items.value = [
      MenuItem(name: "Main", route: Routes.homeRoute, icon: Icons.home),
      MenuItem(name: "Profile", route: Routes.profileRoute, icon: Icons.person),
      if (!isLoggedIn)
        MenuItem(name: "Login", icon: Icons.login, route: Routes.loginRoute),
      if (isLoggedIn)
        MenuItem(name: "Logout", route: Routes.logoutRoute, icon: Icons.logout),
    ];
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
