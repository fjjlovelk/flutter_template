import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../api/user_api.dart';
import '../../router/app_routes.dart';
import '../../store/user_store.dart';
import '../../utils/loading_util.dart';
import 'state.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();

  /// 登录
  void login() async {
    if (state.usernameController.text.trim().isEmpty) {
      TDToast.showWarning("请输入账号", context: Get.context!);
      return;
    }
    if (state.passwordController.text.trim().isEmpty) {
      TDToast.showWarning("请输入密码", context: Get.context!);
      return;
    }
    if (state.captchaController.text.trim().isEmpty) {
      TDToast.showWarning("请输入验证码", context: Get.context!);
      return;
    }
    try {
      LoadingUtil.show('登录中...');
      await Future.delayed(const Duration(seconds: 2));
      await UserStore.to.handleLogin({
        "username": state.usernameController.text,
        "password": state.passwordController.text,
        "captcha": state.captchaController.text,
      });
      TDToast.showSuccess("登录成功", context: Get.context!);
      Get.offAndToNamed(AppRoutes.homeTabs);
    } catch (e) {
      print("login---$e");
    } finally {
      LoadingUtil.dismiss();
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
