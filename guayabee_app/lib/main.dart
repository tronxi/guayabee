import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'url_strategy/web_url_strategy.dart'
    if (dart.library.io) 'url_strategy/web_url_strategy_stub.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:guayabee_app/routes.dart';
import 'package:guayabee_app/services/auth_service.dart';

const appName = "Guayabee";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    configureWebUrlStrategy();
  }
  await GetStorage.init();
  await dotenv.load(fileName: "environments/.env");
  await Get.putAsync<AuthService>(() async => AuthService().init());
  runApp(MyApp());
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
      initialRoute: Routes.homeRoute,
      getPages: Routes.appRoutes(),
    );
  }
}
