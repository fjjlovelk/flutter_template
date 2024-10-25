import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeTabsHomePage extends GetView<HomeTabsHomeController> {
  const HomeTabsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: const Center(
        child: Text('首页'),
      ),
    );
  }
}
