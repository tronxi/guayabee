import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'components/scaffold/custom_scaffold.dart';

const appName = "Guayabee";

void main() async {
  await dotenv.load(fileName: "environments/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: const Color(0xFFFFB300),
          onPrimary: Colors.white,
          secondary: const Color(0xFFFFA000),
          onSecondary: Colors.white,
          surface: const Color(0xFF2C2C2C),
          onSurface: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
      ),
      home: CustomScaffold(),
    );
  }
}
