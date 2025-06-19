import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/theme_config.dart';

/// 搜索框
class SearchTextField extends StatefulWidget {
  /// 控制器
  final TextEditingController controller;

  /// 搜索
  final VoidCallback onSearch;

  /// 占位
  final String placeholder;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onSearch,
    this.placeholder = '请输入...',
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  /// 搜索框焦点
  final FocusNode _searchTextFocus = FocusNode();

  /// 防抖
  Timer? _debounceTimer;

  @override
  void dispose() {
    _searchTextFocus.dispose();
    super.dispose();
  }

  /// 搜索
  void _onSearch() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 150), () {
      _searchTextFocus.unfocus();
      widget.onSearch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ThemeConfig.padding),
      child: TextField(
        controller: widget.controller,
        focusNode: _searchTextFocus,
        style: TextStyle(fontSize: 12.sp),
        textInputAction: TextInputAction.search,
        onSubmitted: (_) {
          _onSearch();
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: ThemeConfig.n2,
          hintText: widget.placeholder,
          hintStyle: TextStyle(fontSize: 12.sp, color: ThemeConfig.n6),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(100),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ThemeConfig.miniPadding,
            vertical: ThemeConfig.smallPadding,
          ),
          isDense: true,
          prefixIconConstraints: BoxConstraints(
            maxWidth: 40.sp,
            maxHeight: 20.sp,
          ),
          suffixIconConstraints: BoxConstraints(
            maxWidth: 60.sp,
            maxHeight: 40.sp,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: ThemeConfig.smallPadding),
            child: Icon(Icons.search, color: ThemeConfig.n6),
          ),
          suffixIcon: TextButton(onPressed: _onSearch, child: const Text('搜索')),
        ),
      ),
    );
  }
}
