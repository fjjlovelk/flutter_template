import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../config/theme_config.dart';
import '../utils/init_app_util.dart';
import '../utils/toast_util.dart';

class DialogUtil {
  /// cupertino风格的dialog
  static void show({
    bool barrierDismissible = false,
    String title = '提示',
    String content = '内容',
    bool cancelButtonShow = true,
    bool confirmButtonShow = true,
    String cancelButtonText = ThemeConfig.cancelButtonText,
    String confirmButtonText = ThemeConfig.confirmButtonText,
    void Function()? onCancel,
    void Function()? onConfirm,
  }) {
    if (Get.context == null) {
      ToastUtil.error('context有误！');
      return;
    }
    InitAppUtil.unFocus(Get.context!);
    List<CupertinoButton> actions = [];
    actions.addIf(
      cancelButtonShow,
      CupertinoButton(
        onPressed: () {
          _dismiss();
          onCancel?.call();
        },
        child: Text(cancelButtonText),
      ),
    );
    actions.addIf(
      confirmButtonShow,
      CupertinoButton(
        onPressed: () {
          _dismiss();
          onConfirm?.call();
        },
        child: Text(confirmButtonText),
      ),
    );
    Navigator.of(Get.context!, rootNavigator: true).push(CupertinoDialogRoute(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      barrierColor: ThemeConfig.modalBackgroundColor,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: EdgeInsets.only(top: ThemeConfig.padding),
          child: Text(
            content,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
        actions: actions,
      ),
    ));
  }

  /// 隐藏
  static void _dismiss() {
    Get.back();
  }
}
