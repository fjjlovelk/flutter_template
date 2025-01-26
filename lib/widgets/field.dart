import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/theme_config.dart';

/// ListTile扩展
class WidgetField extends StatelessWidget {
  /// 标题
  final String label;

  /// 内容
  final Widget? content;

  /// 尾部
  final Widget? trailing;

  /// 是否必填
  final bool required;

  /// 是否开启底部border
  final bool bottomBorder;

  /// 背景颜色
  final Color? backgroundColor;

  /// 点击事件
  final VoidCallback? onTap;

  const WidgetField({
    super.key,
    this.label = '',
    this.required = false,
    this.bottomBorder = true,
    this.backgroundColor,
    this.content,
    this.trailing,
    this.onTap,
  });

  /// 带content的title
  Widget _buildTitleWithContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
          ),
          child: Text(label, style: TextStyle(fontSize: 14.sp)),
        ),
        SizedBox(width: 10.r),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 14.sp, color: ThemeConfig.n7),
              child: content!,
            ),
          ),
        ),
      ],
    );
  }

  /// 不带content的title
  Widget _buildTitleWithNoContent() {
    return Text(label, style: TextStyle(fontSize: 14.sp));
  }

  @override
  Widget build(BuildContext context) {
    // 添加Material组件，防止ListTile在Container等组件中tileColor等属性失效的问题
    return Material(
      child: ListTile(
        onTap: onTap,
        minLeadingWidth: 0,
        horizontalTitleGap: 2.r,
        leading: required
            ? Text('*', style: TextStyle(color: Colors.red, fontSize: 18.sp))
            : null,
        trailing: trailing,
        title: content == null
            ? _buildTitleWithNoContent()
            : _buildTitleWithContent(context),
        dense: true,
        minVerticalPadding: 0,
        minTileHeight: 0,
        titleAlignment: ListTileTitleAlignment.top,
        contentPadding: EdgeInsets.symmetric(
          horizontal: ThemeConfig.padding,
          vertical: ThemeConfig.smallPadding,
        ),
        tileColor: backgroundColor ?? ThemeConfig.white,
        shape: bottomBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: ThemeConfig.n3),
                borderRadius: BorderRadius.zero,
              )
            : null,
      ),
    );
  }
}

/// 选择器field
class SelectField extends StatelessWidget {
  /// 标题
  final String label;

  /// 内容
  final String value;

  /// 是否必填
  final bool required;

  /// placeholder
  final String placeholder;

  /// 是否禁用
  final bool disabled;

  /// 是否开启底部border
  final bool bottomBorder;

  /// 背景颜色
  final Color? backgroundColor;

  /// 点击事件
  final VoidCallback? onTap;

  const SelectField({
    super.key,
    this.label = '',
    this.value = '',
    this.required = false,
    this.placeholder = '请选择',
    this.disabled = false,
    this.bottomBorder = true,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool hasValue = value.isNotEmpty;
    return WidgetField(
      label: label,
      required: required,
      bottomBorder: bottomBorder,
      backgroundColor: backgroundColor,
      onTap: onTap,
      content: Row(
        children: [
          Expanded(
            child: Text(
              hasValue ? value : placeholder,
              textAlign: TextAlign.right,
              style: TextStyle(color: hasValue ? null : ThemeConfig.n5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.r),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: ThemeConfig.n5,
              applyTextScaling: true,
            ),
          ),
        ],
      ),
    );
  }
}

/// 输入框field
class InputField extends StatelessWidget {
  /// 标题
  final String label;

  /// 内容
  final String value;

  /// 是否必填
  final bool required;

  /// placeholder
  final String placeholder;

  /// 是否禁用
  final bool disabled;

  /// 是否开启底部border
  final bool bottomBorder;

  /// 背景颜色
  final Color? backgroundColor;

  /// 最大字数
  final int? maxLength;

  const InputField({
    super.key,
    this.label = '',
    this.value = '',
    this.required = false,
    this.placeholder = '请输入',
    this.disabled = false,
    this.bottomBorder = true,
    this.backgroundColor,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetField(
      label: label,
      required: required,
      bottomBorder: bottomBorder,
      backgroundColor: backgroundColor,
      content: TextField(
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 14.sp),
        maxLines: null,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: placeholder,
          filled: true,
          fillColor: backgroundColor,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
