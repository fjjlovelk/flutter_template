import 'package:flutter_template/api/user_api.dart';
import 'package:flutter_template/router/app_routes.dart';
import 'package:flutter_template/store/user_store.dart';
import 'package:flutter_template/utils/loading_util.dart';
import 'package:get/get.dart';

import 'state.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();

  /// 登录
  void login() async {
    if (state.usernameController.text.trim().isEmpty) {
      LoadingUtil.showInfo("请输入账号");
      return;
    }
    if (state.passwordController.text.trim().isEmpty) {
      LoadingUtil.showInfo("请输入密码");
      return;
    }
    if (state.captchaController.text.trim().isEmpty) {
      LoadingUtil.showInfo("请输入验证码");
      return;
    }
    try {
      LoadingUtil.show('登录中...');
      await Future.delayed(const Duration(milliseconds: 2));
      await UserStore.to.handleLogin({
        "username": state.usernameController.text,
        "password": state.passwordController.text,
        "captcha": state.captchaController.text,
      });
      LoadingUtil.showSuccess('登录成功');
      Get.offAndToNamed(AppRoutes.homeTabs);
    } catch (e) {
      print("login---$e");
    }
  }

  /// 切换密码/明文
  void toggleObscure() {
    state.isObscure.value = !state.isObscure.value;
  }

  /// 获取验证码
  void getCaptcha() async {
    try {
      String res = await UserApi.getCaptchaApi();
      state.captcha.value =
          res.replaceFirst(RegExp('data:image/jpg;base64,'), '');
    } catch (err) {
      print('getCaptcha----$err');
    }
  }
}
