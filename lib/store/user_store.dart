import 'dart:convert';

import 'package:flutter_template/api/user_api.dart';
import 'package:flutter_template/enums/storage_enum.dart';
import 'package:flutter_template/models/user_model.dart';
import 'package:flutter_template/services/storage_service.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;

  final _userInfo = UserModel().obs;

  /// 是否登录
  bool get isLogin => _isLogin.value;

  /// 是否有 token
  bool get hasToken => _userInfo.value.token?.isNotEmpty ?? false;

  /// token
  String get token => _userInfo.value.token ?? '';

  /// 用户信息
  UserModel get userInfo => _userInfo.value;

  @override
  void onInit() {
    super.onInit();
    initUser();
  }

  /// 初始化用户信息
  void initUser() {
    // 从storage中获取isLogin
    _isLogin.value = StorageService.to.getBool(StorageEnum.isLogin.name);

    if (_isLogin.value) {
      // 从storage中获取userInfo
      final userInfoOffline =
          StorageService.to.getString(StorageEnum.userInfo.name);
      if (userInfoOffline.isNotEmpty) {
        _userInfo(UserModel.fromJson(jsonDecode(userInfoOffline)));
      }
    }
  }

  /// 登录
  Future<void> handleLogin(Map<String, dynamic> data) async {
    try {
      UserModel u = await UserApi.loginApi(data);
      _userInfo(u);
      _isLogin.value = true;
      StorageService.to.setString(StorageEnum.userInfo.name, jsonEncode(u));
      StorageService.to.setBool(StorageEnum.isLogin.name, _isLogin.value);
    } catch (e) {
      rethrow;
    }
  }

  /// 退出登录
  void handleLogout([bool isExpire = false]) async {
    try {
      if (!isExpire) {
        await UserApi.logout();
      }
      UserModel u = UserModel();
      _userInfo(u);
      _isLogin.value = false;
      StorageService.to.setString(StorageEnum.userInfo.name, jsonEncode(u));
      StorageService.to.setBool(StorageEnum.isLogin.name, _isLogin.value);
    } catch (e) {
      print('logout---$e');
    }
  }
}
