import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/keep_alive_wrapper.dart';
import '../home_tabs_home/view.dart';
import '../home_tabs_message/view.dart';
import '../home_tabs_mine/view.dart';

class HomeTabsState {
  /// pageView controller
  final PageController pageController = PageController(initialPage: 0);

  /// 当前选中过的tab
  final _currentTab = 0.obs;

  final List<Widget> pages = const [
    KeepAliveWrapper(child: HomeTabsHomePage()),
    KeepAliveWrapper(child: HomeTabsMessagePage()),
    KeepAliveWrapper(child: HomeTabsMinePage()),
  ];

  final List<BottomNavigationBarItem> bottomTabs = const [
    BottomNavigationBarItem(icon: Icon(Icons.widgets), label: '首页'),
    BottomNavigationBarItem(icon: Icon(Icons.forum), label: '消息'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];

  int get currentTab => _currentTab.value;
  set currentTab(int value) => _currentTab.value = value;
}
