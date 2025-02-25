import 'package:get/get.dart';
import 'package:guayabee_app/components/scaffold/custom_scaffold.dart';
import 'package:guayabee_app/pages/communities_page/communities_binding.dart';
import 'package:guayabee_app/pages/communities_page/communities_page.dart';
import 'package:guayabee_app/pages/auth_page/auth_page.dart';
import 'package:guayabee_app/pages/auth_page/logout_page.dart';
import 'package:guayabee_app/pages/create_community_page/create_community_binding.dart';
import 'package:guayabee_app/pages/create_community_page/create_community_page.dart';
import 'package:guayabee_app/pages/home_page/home_binding.dart';
import 'package:guayabee_app/pages/home_page/home_page.dart';
import 'package:guayabee_app/pages/profile_page/profile_page.dart';

class Routes {
  static const String homeRoute = "/";
  static const String profileRoute = "/profile";
  static const String loginRoute = "/login";
  static const String logoutRoute = "/logout";
  static const String communities = "/communities";
  static const String createCommunity = "/createCommunity";

  static appRoutes() => [
    GetPage(
      name: homeRoute,
      binding: HomeBinding(),
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
    GetPage(
      name: communities,
      binding: CommunitiesBinding(),
      page: () => CustomScaffold(body: CommunitiesPage()),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: createCommunity,
      binding: CreateCommunityBinding(),
      page: () => CustomScaffold(body: CreateCommunityPage()),
      transition: Transition.noTransition,
    ),
  ];

  static void change(String route) {
    Get.offAllNamed(route);
  }
}
