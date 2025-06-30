import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/config/theme_config.dart';

class LoadingUtil {
  LoadingUtil() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 2
      ..radius = 10.0
      ..progressColor = ThemeConfig.white
      ..backgroundColor = Colors.black.withValues(alpha: 0.7)
      ..indicatorColor = ThemeConfig.white
      ..textColor = ThemeConfig.white
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  /// 显示loading
  static void show([String text = '加载中...']) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: text, maskType: EasyLoadingMaskType.black);
  }

  /// 隐藏loading
  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }
}
