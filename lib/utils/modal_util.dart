import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/config/theme_config.dart';

class ModalUtil {
  /// 弹框header
  static Widget modalHeader({
    /// 关闭
    VoidCallback? dismiss,

    /// 标题
    String? title,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 48),
        Expanded(
          child: Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(onPressed: dismiss, icon: const Icon(Icons.close)),
      ],
    );
  }

  /// 弹框footer
  static Widget modalFooter({
    /// 重置
    VoidCallback? onReset,

    /// 确认
    VoidCallback? onConfirm,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (onReset != null) _buildTextButton('重置', onReset),
        if (onReset != null) SizedBox(width: 10.r),
        _buildTextButton(
          ThemeConfig.confirmButtonText,
          onConfirm,
          backgroundColor: ThemeConfig.primary,
          foregroundColor: ThemeConfig.white,
        ),
      ],
    );
  }

  /// 显示modal
  static void showModal({
    required BuildContext context,
    required Widget child,

    /// 标题
    String? title,

    /// 是否自动构建内容部分的Container
    bool autoBuildContainer = true,

    /// 关闭
    VoidCallback? dismiss,

    /// 重置
    VoidCallback? onReset,

    /// 确认
    VoidCallback? onConfirm,
  }) {
    showCupertinoModalPopup(
      context: context,
      barrierColor: ThemeConfig.modalBackgroundColor,
      builder: (modalContext) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(bottom: ThemeConfig.safeAreaBottom),
            decoration: BoxDecoration(
              color: ThemeConfig.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ThemeConfig.radius),
                topRight: Radius.circular(ThemeConfig.radius),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                modalHeader(dismiss: dismiss, title: title),
                autoBuildContainer
                    ? SizedBox(height: ThemeConfig.modalHeight, child: child)
                    : child,
                Container(
                  padding: EdgeInsets.only(
                    left: ThemeConfig.padding,
                    right: ThemeConfig.padding,
                    top: ThemeConfig.miniPadding,
                  ),
                  decoration: BoxDecoration(
                    color: ThemeConfig.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, -2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: modalFooter(onConfirm: onConfirm, onReset: onReset),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 关闭弹框
  static void dismissModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 构建按钮
  static Widget _buildTextButton(
    String text,
    VoidCallback? onPressed, {
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: ThemeConfig.primary),
            borderRadius: BorderRadius.all(
              Radius.circular(ThemeConfig.smallRadius),
            ),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
