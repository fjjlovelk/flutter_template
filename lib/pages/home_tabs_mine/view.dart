import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeTabsMinePage extends GetView<HomeTabsMineController> {
  const HomeTabsMinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: const Center(
        child: Text('我的'),
      ),
    );
  }
}
