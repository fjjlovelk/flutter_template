import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginState {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController captchaController = TextEditingController();

  /// 密码eye
  final isObscure = true.obs;

  /// 验证码 base64
  final captcha = "".obs;
}
