import 'package:flutter/material.dart';
import 'package:guayabee_app/components/scaffold/menu_item.dart';
import 'package:guayabee_app/pages/auth_page/auth_page.dart';
import 'package:guayabee_app/pages/auth_page/logout_page.dart';
import 'package:guayabee_app/pages/home_page/home_page.dart';
import 'package:guayabee_app/pages/profile_page/profile_page.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/services/auth_service.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({super.key});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  List<MenuItem>? _items;
  late int _selectedIndex;
  late Widget _selectedPage;
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = Get.put(AuthService());
    _selectedIndex = 0;
    _selectedPage = const HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _items = [
        MenuItem(name: "Main", icon: Icons.home, widget: const HomePage()),
        MenuItem(
          name: "Profile",
          icon: Icons.person,
          widget: const ProfilePage(),
        ),
        if (!_authService.isLoggedIn.value)
          MenuItem(
            name: "Login",
            icon: Icons.login,
            widget: AuthPage(onLogin: _onLogin),
          ),
        if (_authService.isLoggedIn.value)
          MenuItem(
            name: "Logout",
            icon: Icons.logout,
            widget: LogoutPage(onLogout: _onLogin),
          ),
      ];
      return Scaffold(
        appBar: isDesktop(context) ? _buildWebAppBar() : null,
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: _selectedPage,
      );
    });
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items:
          _items!
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.name,
                ),
              )
              .toList(),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  PreferredSizeWidget _buildWebAppBar() {
    return AppBar(
      title: const Text('Guayabee'),
      automaticallyImplyLeading: false,
      actions:
          _items!
              .asMap()
              .entries
              .map(
                (entry) => TextButton(
                  onPressed: () => _onItemTapped(entry.key),
                  child: Text(entry.value.name),
                ),
              )
              .toList(),
    );
  }

  void _onLogin() {
    _onItemTapped(0);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedPage = _items![_selectedIndex].widget;
    });
  }

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
}
