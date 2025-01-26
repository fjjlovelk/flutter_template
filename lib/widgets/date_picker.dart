import 'package:flutter/material.dart';
import 'package:flutter_picker_plus/picker.dart';
import 'package:intl/intl.dart';

import '../config/theme_config.dart';
import '../utils/logger_util.dart';
import '../utils/modal_util.dart';

enum DatePickerType {
  Y(PickerDateTimeType.kY, 'yyyy'),
  YM(PickerDateTimeType.kYM, 'yyyy-MM'),
  YMD(PickerDateTimeType.kYMD, 'yyyy-MM-dd'),
  YMDHM(PickerDateTimeType.kYMDHM, 'yyyy-MM-dd HH:mm'),
  YMDHMS(PickerDateTimeType.kYMDHMS, 'yyyy-MM-dd HH:mm:ss'),
  HM(PickerDateTimeType.kHM, 'HH:mm'),
  HMS(PickerDateTimeType.kHMS, 'HH:mm:ss');

  final int pickerType;
  final String valueFormat;

  const DatePickerType(this.pickerType, this.valueFormat);
}

class DatePicker extends StatefulWidget {
  /// 默认选中时间 受控
  final String? value;

  /// 值改变后的回调
  final ValueChanged<String?>? onChange;

  /// 触发器
  final Widget Function(String? dateTime) builder;

  /// 类型
  final DatePickerType type;

  /// 最小时间
  final String? minValue;

  /// 最大时间
  final String? maxValue;

  /// 标题
  final String? title;

  /// 是否允许删除
  final bool allowClear;

  const DatePicker({
    super.key,
    required this.builder,
    this.value,
    this.minValue,
    this.maxValue,
    this.onChange,
    this.type = DatePickerType.YMD,
    this.allowClear = true,
    this.title,
  });

  /// button类型的trigger
  static Widget buttonTrigger({required Widget child}) {
    return TextButton(
      onPressed: () {},
      child: child,
    );
  }

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  /// picker实例
  Picker? _picker;

  /// adapter实例
  late DateTimePickerAdapter _adapter;

  /// 内部状态
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
    _adapter = _createAdapter();
  }

  @override
  didUpdateWidget(covariant DatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value;
      });
    }
    if (widget.minValue != oldWidget.minValue ||
        widget.maxValue != oldWidget.maxValue) {
      setState(() {
        _adapter = _createAdapter();
        _picker?.adapter = _adapter;
      });
    }
  }

  // 创建一个新的 DateTimePickerAdapter
  DateTimePickerAdapter _createAdapter() {
    return DateTimePickerAdapter(
      type: widget.type.pickerType,
      yearSuffix: "年",
      monthSuffix: "月",
      daySuffix: "日",
      hourSuffix: "时",
      minuteSuffix: "分",
      secondSuffix: "秒",
      minValue: _parseDateString(widget.minValue),
      maxValue: _parseDateString(widget.maxValue),
      value: _parseDateString(_value) ?? DateTime.now(),
      months: [
        "1月",
        "2月",
        "3月",
        "4月",
        "5月",
        "6月",
        "7月",
        "8月",
        "9月",
        "10月",
        "11月",
        "12月",
      ],
    );
  }

  /// 解析字符串为 DateTime 对象
  DateTime? _parseDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }
    try {
      return DateFormat(widget.type.valueFormat).parseStrict(dateString);
    } catch (e) {
      LoggerUtil.error("Failed to parse date string: $dateString");
      return null;
    }
  }

  /// 打开picker
  void _showDatePicker() {
    _picker ??= Picker(
      height: ThemeConfig.smallModalHeight,
      hideHeader: true,
      adapter: _adapter,
      backgroundColor: ThemeConfig.white,
      selectedTextStyle: TextStyle(color: ThemeConfig.primary),
    );
    ModalUtil.showModal(
      title: widget.title,
      context: context,
      onConfirm: _onConfirm,
      dismiss: _dismiss,
      autoBuildContainer: false,
      onReset: widget.allowClear ? _onReset : null,
      child: _picker!.makePicker(),
    );
  }

  /// 关闭弹框
  void _dismiss() {
    ModalUtil.dismissModal(context);
  }

  /// 确认
  void _onConfirm() {
    final selectedValue = _adapter.value;
    String value = '';
    if (selectedValue != null) {
      value = DateFormat(widget.type.valueFormat).format(selectedValue);
    }
    setState(() {
      _value = value;
    });
    widget.onChange?.call(value);
    _dismiss();
  }

  /// 重置
  void _onReset() {
    setState(() {
      _value = null;
    });
    widget.onChange?.call(null);
    _dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showDatePicker,
      child: widget.builder(_value),
    );
  }
}
