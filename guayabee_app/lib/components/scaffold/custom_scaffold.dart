import 'package:flutter/material.dart';
import 'package:guayabee_app/components/scaffold/menu_item.dart';
import 'package:guayabee_app/pages/home_page/home_page.dart';
import 'package:guayabee_app/pages/profile_page/profile_page.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({super.key});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  late List<MenuItem> _items;
  late int _selectedIndex;
  late Widget _selectedPage;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _items = [
      MenuItem(name: "Main", icon: Icons.home, widget: const HomePage()),
      MenuItem(
        name: "Profile",
        icon: Icons.person,
        widget: const ProfilePage(),
      ),
      MenuItem(name: "Login", icon: Icons.login, widget: const ProfilePage()),
    ];
    _selectedPage = _items[_selectedIndex].widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isDesktop(context) ? _buildWebAppBar() : null,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _selectedPage,
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items:
          _items
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
          _items
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedPage = _items[_selectedIndex].widget;
    });
  }

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
}
