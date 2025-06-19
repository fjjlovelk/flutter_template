import 'package:get/get.dart';

import '../home_tabs_home/controller.dart';
import '../home_tabs_message/controller.dart';
import '../home_tabs_mine/controller.dart';
import 'controller.dart';

class HomeTabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabsController());
    Get.lazyPut(() => HomeTabsHomeController());
    Get.lazyPut(() => HomeTabsMessageController());
    Get.lazyPut(() => HomeTabsMineController());
  }
}
