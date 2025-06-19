import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../store/user_store.dart';
import 'state.dart';

class HomeTabsMineController extends GetxController {
  final HomeTabsMineState state = HomeTabsMineState();

  /// 退出登录
  void logout() {
    showGeneralDialog(
      context: Get.context!,
      pageBuilder: (context, animation, secondaryAnimation) {
        return TDAlertDialog(
          title: '确认退出登录吗？',
          rightBtnAction: () {
            Get.back();
            UserStore.to.logoutAndToLogin();
          },
        );
      },
    );
  }
}
