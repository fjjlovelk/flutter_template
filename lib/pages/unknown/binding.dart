import 'package:flutter_template/pages/unknown/controller.dart';
import 'package:get/get.dart';

class UnknownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UnknownController());
  }
}
