import 'package:get/get.dart';
import 'package:guayabee_app/pages/home_page/home_binding.dart';
import 'package:guayabee_app/pages/home_page/home_page.dart';

class Routes {
  static const String mainRoute = "/main";

  static appRoutes() => [
    GetPage(
      name: mainRoute,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
