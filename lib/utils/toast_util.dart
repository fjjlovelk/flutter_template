import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class ToastUtil {
  /// 成功toast
  static void success(String message) {
    TDToast.showSuccess(
      message,
      context: Get.context!,
      direction: IconTextDirection.vertical,
    );
  }

  /// 失败toast
  static void error(String message) {
    TDToast.showFail(
      message,
      context: Get.context!,
      direction: IconTextDirection.vertical,
    );
  }

  /// 失败toast
  static void warning(String message) {
    TDToast.showWarning(
      message,
      context: Get.context!,
      direction: IconTextDirection.vertical,
    );
  }

  /// 信息toast
  static void info(String message) {
    TDToast.showText(message, context: Get.context!);
  }
}
