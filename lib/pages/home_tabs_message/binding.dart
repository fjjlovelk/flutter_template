import 'package:get/get.dart';

import 'controller.dart';

class HomeTabsMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabsMessageController());
  }
}
