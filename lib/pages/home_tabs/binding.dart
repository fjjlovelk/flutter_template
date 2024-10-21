import 'package:flutter_template/pages/home_tabs/controller.dart';
import 'package:get/get.dart';

class HomeTabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabsController());
  }
}
