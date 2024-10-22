import 'package:flutter_template/pages/home_tabs_message/controller.dart';
import 'package:get/get.dart';

class HomeTabsMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabsMessageController());
  }
}
