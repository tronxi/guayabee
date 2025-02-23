import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guayabee_app/shared/colors.dart';
import 'package:guayabee_app/shared/routes.dart';

const appName = "Guayabee";

void main() {
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Theme.of(context).primaryCustomColor,
        ),
        useMaterial3: true,
      ),
      initialRoute: Routes.mainRoute,
      getPages: Routes.appRoutes(),
    );
  }
}
