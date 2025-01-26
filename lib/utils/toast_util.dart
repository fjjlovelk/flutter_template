import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../config/theme_config.dart';

class ToastUtil {
  static Widget _buildContainer({
    IconData? icon,
    required String message,
  }) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width / 2),
        padding: EdgeInsets.all(ThemeConfig.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ThemeConfig.radius)),
          color: Colors.black.withValues(alpha: 0.7),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: ThemeConfig.white,
                size: 40.sp,
              ),
            Text(
              message,
              maxLines: 20,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(color: ThemeConfig.white),
            ),
          ],
        ),
      ),
    );
  }

  /// 成功toast
  static void success(String message) {
    showToastWidget(
      _buildContainer(icon: Icons.check, message: message),
      dismissOtherToast: true,
    );
  }

  /// 失败toast
  static void error(String message) {
    showToastWidget(
      _buildContainer(icon: Icons.close, message: message),
      dismissOtherToast: true,
    );
  }

  /// 信息toast
  static void info(String message) {
    showToastWidget(
      _buildContainer(message: message),
      dismissOtherToast: true,
    );
  }
}
