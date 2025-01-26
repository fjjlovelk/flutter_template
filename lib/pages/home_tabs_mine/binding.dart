import 'package:get/get.dart';

import 'controller.dart';

class HomeTabsMineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabsMineController());
  }
}
