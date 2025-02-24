import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/components/scaffold/custom_scaffold_controller.dart';
import 'package:guayabee_app/routes.dart';

class CustomScaffold extends StatefulWidget {
  final Widget body;

  const CustomScaffold({super.key, required this.body});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  final CustomScaffoldController _customScaffoldController = Get.put(
    CustomScaffoldController(),
    permanent: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isDesktop(context) ? _buildWebAppBar() : null,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: widget.body,
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        items:
            _customScaffoldController.items
                .map(
                  (item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    label: item.name,
                  ),
                )
                .toList(),
        currentIndex: _customScaffoldController.selectedIndex.value,
        onTap: _onItemTapped,
      );
    });
  }

  void _onItemTapped(int index) {
    _customScaffoldController.changeIndex(index);
    Routes.change(_getRouteFromIndex(index));
  }

  PreferredSizeWidget _buildWebAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Obx(
        () => AppBar(
          title: const Text('Guayabee'),
          automaticallyImplyLeading: false,
          actions:
              _customScaffoldController.items
                  .asMap()
                  .entries
                  .map(
                    (entry) => TextButton(
                      onPressed: () => _onItemTapped(entry.key),
                      child: Text(entry.value.name),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }

  String _getRouteFromIndex(int index) {
    return _customScaffoldController.items[index].route;
  }

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
}
