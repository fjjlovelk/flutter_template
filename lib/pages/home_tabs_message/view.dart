import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeTabsMessagePage extends GetView<HomeTabsMessageController> {
  const HomeTabsMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('消息'),
      ),
      body: const Center(
        child: Text('消息'),
      ),
    );
  }
}
