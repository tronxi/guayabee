import 'package:get/get.dart';
import 'package:guayabee_app/pages/home_page/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
