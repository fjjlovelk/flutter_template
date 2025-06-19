import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinyin/pinyin.dart';

import '../config/theme_config.dart';
import '../utils/modal_util.dart';
import 'search_text_field.dart';

/// 单选选择器
class Select<T, K> extends StatefulWidget {
  /// 标题
  final String? title;

  /// 默认选中值 受控
  final T? value;

  /// 是否允许清空
  final bool allowClear;

  /// 选项list
  final List<K> options;

  /// 值改变后的回调
  final ValueChanged<K?>? onChange;

  /// 选项 是否禁用
  final bool Function(K value, int index)? disableBuilder;

  /// 选项 label
  final String Function(K value, int index) labelBuilder;

  /// 选项 value
  final T Function(K value, int index) valueBuilder;

  final Widget Function(K? value, VoidCallback onOpen, VoidCallback onReset)
  builder;

  const Select({
    super.key,
    this.title,
    this.value,
    this.allowClear = true,
    this.options = const [],
    this.onChange,
    this.disableBuilder,
    required this.labelBuilder,
    required this.valueBuilder,
    required this.builder,
  });

  @override
  State<Select> createState() => _SelectState<T, K>();
}

class _SelectState<T, K> extends State<Select<T, K>> {
  /// 选中的值
  final _selectedItemNotifier = ValueNotifier<K?>(null);

  /// 筛选过的list
  final _filteredOptionsNotifier = ValueNotifier<List<K>>([]);

  /// 搜索框控制器
  final TextEditingController _searchTextController = TextEditingController();

  /// 内部最终选中的项
  K? _finalSelectedItem;

  @override
  void initState() {
    super.initState();
    _filteredOptionsNotifier.value = widget.options;
    _finalSelectedItem = findSelectedItem();
  }

  // @override
  // didUpdateWidget(covariant Select<T, K> oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.options != widget.options) {
  //     _filteredOptionsNotifier.value = widget.options;
  //   }
  //   if (oldWidget.value != widget.value ||
  //       oldWidget.options != widget.options) {
  //     /// value或者options更改后，重新刷新组件
  //     setState(() {
  //       _finalSelectedItem = findSelectedItem();
  //     });
  //   }
  // }

  @override
  void dispose() {
    _selectedItemNotifier.dispose();
    _filteredOptionsNotifier.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  /// 查找被选中的项
  K? findSelectedItem() {
    if (widget.value == null || _filteredOptionsNotifier.value.isEmpty) {
      return null;
    }
    for (int i = 0; i < _filteredOptionsNotifier.value.length; i++) {
      final itemValue = widget.valueBuilder(
        _filteredOptionsNotifier.value[i],
        i,
      );
      if (itemValue == widget.value) {
        return _filteredOptionsNotifier.value[i];
      }
    }
    return null;
  }

  /// 选中
  void _onSelect(K item) {
    _selectedItemNotifier.value = item;
  }

  /// 搜索
  void _onSearch() {
    final value = _searchTextController.text.toLowerCase();
    if (value.isEmpty) {
      _filteredOptionsNotifier.value = widget.options;
      return;
    }
    final List<K> result = [];
    for (int i = 0; i < widget.options.length; i++) {
      final itemLabel = widget.labelBuilder(widget.options[i], i);
      final pinyinLabel = PinyinHelper.getPinyinE(itemLabel);
      final pinyinFirstLabel = PinyinHelper.getShortPinyin(itemLabel);
      if (itemLabel.contains(value) ||
          pinyinLabel.contains(value) ||
          pinyinFirstLabel.contains(value)) {
        result.add(widget.options[i]);
      }
    }
    _filteredOptionsNotifier.value = result;
  }

  /// 关闭弹框
  void _dismiss() {
    ModalUtil.dismissModal(context);
  }

  /// 重置
  void _onReset() {
    if (!widget.allowClear) {
      return;
    }
    _dismiss();
    setState(() {
      _finalSelectedItem = null;
    });
    widget.onChange?.call(null);
  }

  /// 确认
  void _onConfirm() {
    if (_selectedItemNotifier.value == null) {
      return;
    }
    setState(() {
      _finalSelectedItem = _selectedItemNotifier.value;
    });
    widget.onChange?.call(_selectedItemNotifier.value);
    _dismiss();
  }

  /// 列表项
  Widget _buildContentItem(int index) {
    final item = _filteredOptionsNotifier.value[index];
    final itemLabel = widget.labelBuilder(item, index);
    final isDisabled = widget.disableBuilder?.call(item, index) ?? false;
    final isSelected = _selectedItemNotifier.value == item;
    Color? fontColor;
    if (isDisabled) {
      fontColor = ThemeConfig.n5;
    } else if (isSelected) {
      fontColor = ThemeConfig.primary;
    }
    return ListTile(
      onTap: isDisabled ? null : () => _onSelect(item),
      minTileHeight: 0,
      title: Text(itemLabel, style: TextStyle(color: fontColor)),
      trailing: Icon(
        Icons.check,
        color: ThemeConfig.primary.withValues(alpha: isSelected ? 1 : 0),
      ),
    );
  }

  /// 列表内容
  Widget _buildContent() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _selectedItemNotifier,
        _filteredOptionsNotifier,
      ]),
      builder: (context, child) {
        return _filteredOptionsNotifier.value.isEmpty
            ? const Center(child: Text("暂无数据～"))
            : ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _filteredOptionsNotifier.value.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: ThemeConfig.n3, height: 5);
                },
                itemBuilder: (context, index) => _buildContentItem(index),
              );
      },
    );
  }

  /// 打开弹框
  void _showOverlay() {
    if (_selectedItemNotifier.value != _finalSelectedItem) {
      _selectedItemNotifier.value = _finalSelectedItem;
    }
    _filteredOptionsNotifier.value = widget.options;
    _searchTextController.clear();
    ModalUtil.showModal(
      title: widget.title,
      context: context,
      onReset: widget.allowClear ? _onReset : null,
      dismiss: _dismiss,
      onConfirm: _onConfirm,
      child: Column(
        children: [
          SearchTextField(
            onSearch: _onSearch,
            controller: _searchTextController,
            placeholder: '输入拼音、文字以搜索',
          ),
          SizedBox(height: 5.r),
          Expanded(child: _buildContent()),
          SizedBox(height: 5.r),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_finalSelectedItem, _showOverlay, _onReset);
  }
}

/// 多选选择器
class MultiSelect<T, K> extends StatefulWidget {
  /// 标题
  final String? title;

  /// 默认选中值 受控
  final List<T> value;

  /// 是否允许清空
  final bool allowClear;

  /// 选项list
  final List<K> options;

  /// 值改变后的回调
  final ValueChanged<List<K>>? onChange;

  /// 选项 是否禁用
  final bool Function(K value, int index)? disableBuilder;

  /// 选项 label
  final String Function(K value, int index) labelBuilder;

  /// 选项 value
  final T Function(K value, int index) valueBuilder;

  final Widget Function(
    List<K> value,
    VoidCallback onOpen,
    VoidCallback onReset,
  )
  builder;

  const MultiSelect({
    super.key,
    this.title,
    this.value = const [],
    this.allowClear = true,
    this.options = const [],
    this.onChange,
    this.disableBuilder,
    required this.labelBuilder,
    required this.valueBuilder,
    required this.builder,
  });

  @override
  State<MultiSelect> createState() => _MultiSelectState<T, K>();
}

class _MultiSelectState<T, K> extends State<MultiSelect<T, K>> {
  /// 选中的值
  final _selectedItemsNotifier = ValueNotifier<List<K>>([]);

  /// 筛选过的list
  final _filteredOptionsNotifier = ValueNotifier<List<K>>([]);

  /// 搜索框控制器
  final TextEditingController _searchTextController = TextEditingController();

  /// 内部最终选中的项
  List<K> _finalSelectedItems = const [];

  @override
  void initState() {
    super.initState();
    _finalSelectedItems = findSelectedItems();
    _filteredOptionsNotifier.value = widget.options;
  }

  // @override
  // didUpdateWidget(covariant MultiSelect<T, K> oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.value != widget.value ||
  //       oldWidget.options != widget.options) {
  //     /// value或者options更改后，重新刷新组件
  //     setState(() {
  //       _finalSelectedItems = findSelectedItems();
  //     });
  //   }
  //   if (oldWidget.options != widget.options) {
  //     _filteredOptionsNotifier.value = widget.options;
  //   }
  // }

  @override
  void dispose() {
    _selectedItemsNotifier.dispose();
    _filteredOptionsNotifier.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  /// 查找被选中的项
  List<K> findSelectedItems() {
    if (widget.value.isEmpty || _filteredOptionsNotifier.value.isEmpty) {
      return [];
    }
    final List<K> result = [];
    for (int i = 0; i < _filteredOptionsNotifier.value.length; i++) {
      final itemValue = widget.valueBuilder(
        _filteredOptionsNotifier.value[i],
        i,
      );
      if (itemValue == widget.value) {
        result.add(_filteredOptionsNotifier.value[i]);
      }
    }
    return result;
  }

  /// 选中
  void _onSelect(K item) {
    // AnimatedBuilder不会监听List内部的变化，所以需要浅拷贝再赋值
    final updatedList = List<K>.from(_selectedItemsNotifier.value);
    if (updatedList.contains(item)) {
      updatedList.remove(item);
    } else {
      updatedList.add(item);
    }
    _selectedItemsNotifier.value = updatedList;
  }

  /// 搜索
  void _onSearch() {
    final value = _searchTextController.text.toLowerCase();
    if (value.isEmpty) {
      _filteredOptionsNotifier.value = widget.options;
      return;
    }
    final List<K> result = [];
    for (int i = 0; i < widget.options.length; i++) {
      final itemLabel = widget.labelBuilder(widget.options[i], i);
      final pinyinLabel = PinyinHelper.getPinyinE(itemLabel);
      final pinyinFirstLabel = PinyinHelper.getShortPinyin(itemLabel);
      if (itemLabel.contains(value) ||
          pinyinLabel.contains(value) ||
          pinyinFirstLabel.contains(value)) {
        result.add(widget.options[i]);
      }
    }
    _filteredOptionsNotifier.value = result;
  }

  /// 关闭弹框
  void _dismiss() {
    ModalUtil.dismissModal(context);
  }

  /// 重置
  void _onReset() {
    if (!widget.allowClear) {
      return;
    }
    _dismiss();
    setState(() {
      _finalSelectedItems = [];
    });
    widget.onChange?.call([]);
  }

  /// 确认
  void _onConfirm() {
    if (_selectedItemsNotifier.value.isEmpty) {
      return;
    }
    setState(() {
      _finalSelectedItems = _selectedItemsNotifier.value;
    });
    widget.onChange?.call(_selectedItemsNotifier.value);
    _dismiss();
  }

  /// 列表项
  Widget _buildContentItem(int index) {
    final item = _filteredOptionsNotifier.value[index];
    final itemLabel = widget.labelBuilder(item, index);
    final isDisabled = widget.disableBuilder?.call(item, index) ?? false;
    final isSelected = _selectedItemsNotifier.value.contains(item);
    Color? fontColor;
    if (isDisabled) {
      fontColor = ThemeConfig.n5;
    } else if (isSelected) {
      fontColor = ThemeConfig.primary;
    }
    return ListTile(
      onTap: isDisabled ? null : () => _onSelect(item),
      minTileHeight: 0,
      title: Text(itemLabel, style: TextStyle(color: fontColor)),
      trailing: Icon(
        Icons.check,
        color: ThemeConfig.primary.withValues(alpha: isSelected ? 1 : 0),
      ),
    );
  }

  /// 列表内容
  Widget _buildContent() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _selectedItemsNotifier,
        _filteredOptionsNotifier,
      ]),
      builder: (context, child) {
        return _filteredOptionsNotifier.value.isEmpty
            ? const Center(child: Text("暂无数据～"))
            : ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _filteredOptionsNotifier.value.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: ThemeConfig.n3, height: 5);
                },
                itemBuilder: (context, index) => _buildContentItem(index),
              );
      },
    );
  }

  /// 打开弹框
  void _showOverlay() {
    if (_selectedItemsNotifier.value != _finalSelectedItems) {
      _selectedItemsNotifier.value = _finalSelectedItems;
    }
    _filteredOptionsNotifier.value = widget.options;
    _searchTextController.clear();
    ModalUtil.showModal(
      title: widget.title,
      context: context,
      onReset: widget.allowClear ? _onReset : null,
      dismiss: _dismiss,
      onConfirm: _onConfirm,
      child: Column(
        children: [
          SearchTextField(
            onSearch: _onSearch,
            controller: _searchTextController,
            placeholder: '输入拼音、文字以搜索',
          ),
          SizedBox(height: 5.r),
          Expanded(child: _buildContent()),
          SizedBox(height: 5.r),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_finalSelectedItems, _showOverlay, _onReset);
  }
}
