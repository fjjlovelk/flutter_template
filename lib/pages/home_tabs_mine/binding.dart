import 'package:flutter_template/pages/home_tabs_mine/controller.dart';
import 'package:get/get.dart';

class HomeTabsMineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabsMineController());
  }
}
