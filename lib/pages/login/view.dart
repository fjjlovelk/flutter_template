import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/config/assets_config.dart';
import 'package:flutter_template/config/theme_config.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ThemeConfig.white, body: _buildForm());
  }

  /// 表单区域
  Widget _buildForm() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TDInput(
              leftLabelSpace: 0,
              showBottomDivider: false,
              needClear: false,
              controller: controller.state.usernameController,
              leftIcon: const Icon(Icons.person_outline),
              hintText: '请输入账号',
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ThemeConfig.n4)),
              ),
            ),
            Obx(
              () => TDInput(
                leftLabelSpace: 0,
                showBottomDivider: false,
                needClear: false,
                controller: controller.state.passwordController,
                leftIcon: const Icon(Icons.lock_outline),
                hintText: '请输入密码',
                obscureText: controller.state.isObscure.value,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: ThemeConfig.n4)),
                ),
                rightBtn: Icon(
                  controller.state.isObscure.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onBtnTap: () {
                  controller.toggleObscure();
                },
              ),
            ),
            TDInput(
              leftLabelSpace: 0,
              showBottomDivider: false,
              needClear: false,
              controller: controller.state.captchaController,
              leftIcon: const Icon(Icons.code),
              hintText: '请输入验证码',
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ThemeConfig.n4)),
              ),
              rightBtn: GestureDetector(
                onTap: controller.getCaptcha,
                child: Obx(
                  () => controller.state.captcha.value.isEmpty
                      ? Image.asset(
                          AssetsConfig.imagesEmptyCaptcha,
                          width: 100.w,
                          height: 35.h,
                          fit: BoxFit.cover,
                        )
                      : Image.memory(
                          base64Decode(controller.state.captcha.value),
                          width: 100.w,
                          height: 35.h,
                          fit: BoxFit.fill,
                          gaplessPlayback: true,
                        ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            TDButton(
              text: '登录',
              isBlock: true,
              shape: TDButtonShape.round,
              size: TDButtonSize.large,
              margin: EdgeInsets.zero,
              theme: TDButtonTheme.primary,
              onTap: () {
                controller.login();
              },
            ),
          ],
        ),
      ),
    );
  }
}
