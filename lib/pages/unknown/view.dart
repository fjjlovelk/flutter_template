import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class UnknownPage extends GetView<UnknownController> {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('未知页面'),
      ),
      body: const Center(
        child: Text('你仿佛来到了没有知识的荒原~'),
      ),
    );
  }
}
