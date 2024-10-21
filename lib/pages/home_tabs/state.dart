import 'package:flutter/material.dart';
import 'package:flutter_template/widgets/keep_alive_wrapper.dart';
import 'package:get/get.dart';

class HomeTabsState {
  /// pageView controller
  final PageController pageController = PageController(initialPage: 0);

  /// 当前选中过的tab
  final _currentTab = 0.obs;

  final List<Widget> pages = const [
    KeepAliveWrapper(child: Text('data1')),
    KeepAliveWrapper(keepAlive: true, child: Text('data2')),
    KeepAliveWrapper(keepAlive: true, child: Text('data3')),
  ];

  final List<BottomNavigationBarItem> bottomTabs = const [
    BottomNavigationBarItem(icon: Icon(Icons.widgets), label: '首页'),
    BottomNavigationBarItem(icon: Icon(Icons.forum), label: '消息'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];

  int get currentTab => _currentTab.value;
  set currentTab(int value) => _currentTab.value = value;
}
