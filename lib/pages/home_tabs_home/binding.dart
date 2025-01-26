import 'package:get/get.dart';

import '../home_tabs/controller.dart';

class HomeTabsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabsController());
  }
}
