import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/config/assets_config.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'controller.dart';

class HomeTabsMinePage extends GetView<HomeTabsMineController> {
  const HomeTabsMinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: ListView(
        children: [
          TDCell(
            title: '管理员',
            description: '我是管理员',
            arrow: true,
            image: AssetImage(AssetsConfig.imagesAvatar),
          ),
          SizedBox(height: 10.r),
          TDCell(
            title: '退出登录',
            leftIcon: Icons.logout,
            arrow: true,
            onClick: (c) => controller.logout(),
          ),
        ],
      ),
    );
  }
}
