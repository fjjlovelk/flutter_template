import 'package:get/get.dart';

import 'state.dart';

class HomeTabsController extends GetxController {
  final HomeTabsState state = HomeTabsState();

  @override
  void onClose() {
    state.pageController.dispose();
    super.onClose();
  }

  /// bottomNavigationBar点击事件
  void bottomNavigationBarTap(int index) {
    // 切换page时会触发onPageChanged事件，因此此时无需设置currentTab
    state.pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    state.currentTab = index;
  }
}
