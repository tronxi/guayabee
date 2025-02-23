import 'package:flutter/material.dart';

class MenuItem {
  final String name;
  final IconData icon;
  final Widget widget;

  MenuItem({
    required this.name,
    required this.icon,
    required this.widget,
  });
}
