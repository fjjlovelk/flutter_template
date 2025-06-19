import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeTabsPage extends GetView<HomeTabsController> {
  const HomeTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.state.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: controller.onPageChanged,
        children: controller.state.pages,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: controller.state.bottomTabs,
          currentIndex: controller.state.currentTab,
          selectedFontSize: 12.sp,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: controller.bottomNavigationBarTap,
        ),
      ),
    );
  }
}
