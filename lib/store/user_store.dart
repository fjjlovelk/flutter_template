import 'dart:convert';

import 'package:flutter_template/api/user/models/login_params/login_params.dart';
import 'package:flutter_template/api/user/user_api.dart';
import 'package:flutter_template/enums/storage_enum.dart';
import 'package:flutter_template/models/user_model/user_model.dart';
import 'package:flutter_template/router/app_routes.dart';
import 'package:flutter_template/services/storage_service.dart';
import 'package:flutter_template/utils/loading_util.dart';
import 'package:flutter_template/utils/logger_util.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _userInfo = Rxn<UserModel>();

  /// 是否有 token
  bool get hasToken => _userInfo.value?.token?.isNotEmpty ?? false;

  /// token
  String get token => _userInfo.value?.token ?? '';

  /// 用户信息
  UserModel? get userInfo => _userInfo.value;

  @override
  void onInit() {
    super.onInit();
    initUser();
  }

  /// 初始化用户信息
  void initUser() {
    // 从storage中获取userInfo
    final userInfoOffline = StorageService.to.getString(
      StorageEnum.userInfo.name,
    );
    if (userInfoOffline.isNotEmpty) {
      _userInfo(UserModel.fromJson(jsonDecode(userInfoOffline)));
    }
  }

  /// 登录
  Future<void> handleLogin(LoginParams data) async {
    UserModel u = await UserApi.login(data);
    _userInfo(u);
    StorageService.to.setString(StorageEnum.userInfo.name, jsonEncode(u));
  }

  /// 退出登录
  Future<void> handleLogout([bool isExpire = false]) async {
    if (!isExpire) {
      // await UserApi.logout();
    }
    _userInfo(null);
    resetStore();
  }

  /// 退出登录并且回到登录页
  void logoutAndToLogin([bool isExpire = false]) async {
    try {
      LoadingUtil.show('正在退出...');
      await UserStore.to.handleLogout(isExpire);
      Get.offAllNamed(AppRoutes.login);
    } catch (err) {
      LoggerUtil.error(err);
    } finally {
      LoadingUtil.dismiss();
    }
  }

  /// 重置store
  void resetStore() {
    StorageService.to.remove(StorageEnum.userInfo.name);
  }
}
