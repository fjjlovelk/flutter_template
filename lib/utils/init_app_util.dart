import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../http/http_custom_overrides.dart';
import '../services/storage_service.dart';
import '../store/user_store.dart';
import 'loading_util.dart';

class InitAppUtil {
  /// 初始化
  static Future<void> init() async {
    // 在系统和flutter通信前进行自定义方法
    WidgetsFlutterBinding.ensureInitialized();
    // 固定App方向为上，即不受横屏影响
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // 加载loading实例
    LoadingUtil();
    // 全局忽略https证书
    HttpOverrides.global = HttpCustomOverrides();
    // 注入StorageService
    await Get.putAsync<StorageService>(() => StorageService().init());
    // 注入UserStore
    Get.put<UserStore>(UserStore());
  }

  /// 取消焦点
  static void unFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
