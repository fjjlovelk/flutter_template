import 'package:get/get.dart';

import 'controller.dart';

class HomeTabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabsController());
  }
}
