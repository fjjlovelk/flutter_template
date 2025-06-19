import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../config/theme_config.dart';

/// 可展开tile
class CustomExpansionTile extends StatelessWidget {
  /// 是否默认展开
  final bool initiallyExpanded;

  /// 标题
  final Widget title;

  /// 子节点
  final List<Widget> children;

  /// 折叠图标
  final IconData? trailingIcon;

  /// 是否显示折叠图标
  final bool showTrailingIcon;

  /// 是否启用
  final bool enabled;

  /// 是否展开
  final _isExpanded = true.obs;

  CustomExpansionTile({
    super.key,
    this.initiallyExpanded = true,
    this.enabled = true,
    this.showTrailingIcon = true,
    required this.title,
    required this.children,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    _isExpanded.value = initiallyExpanded;
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      title: title,
      tilePadding: EdgeInsets.zero,
      enabled: enabled,
      showTrailingIcon: showTrailingIcon,
      shape: Border.all(style: BorderStyle.none),
      collapsedShape: Border.all(style: BorderStyle.none),
      minTileHeight: 0,
      onExpansionChanged: (expanded) {
        _isExpanded.value = expanded;
      },
      iconColor: ThemeConfig.info,
      collapsedIconColor: ThemeConfig.info,
      trailing: Obx(
        () => AnimatedRotation(
          turns: _isExpanded.value ? -0.5 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            trailingIcon ?? Icons.expand_circle_down_outlined,
            size: 20.sp,
          ),
        ),
      ),
      children: children,
    );
  }
}
