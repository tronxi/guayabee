import 'package:get/get.dart';
import 'package:guayabee_app/components/scaffold/custom_scaffold.dart';
import 'package:guayabee_app/pages/auth_page/auth_page.dart';
import 'package:guayabee_app/pages/auth_page/logout_page.dart';
import 'package:guayabee_app/pages/home_page/home_page.dart';
import 'package:guayabee_app/pages/profile_page/profile_page.dart';

class Routes {
  static const String homeRoute = "/";
  static const String profileRoute = "/profile";
  static const String loginRoute = "/login";
  static const String logoutRoute = "/logout";

  static appRoutes() => [
    GetPage(
      name: homeRoute,
      page: () => const CustomScaffold(body: HomePage()),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: profileRoute,
      page: () => const CustomScaffold(body: ProfilePage()),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: loginRoute,
      page: () => const CustomScaffold(body: AuthPage()),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: logoutRoute,
      page: () => const CustomScaffold(body: LogoutPage()),
      transition: Transition.noTransition,
    ),
  ];

  static void change(String route) {
    Get.offAllNamed(route);
  }
}
