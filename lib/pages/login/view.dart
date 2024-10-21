import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2d3e54),
      body: _buildForm(),
    );
  }

  /// 表单区域
  Widget _buildForm() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.state.usernameController,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14.sp,
              ),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "请输入账号",
                hintStyle: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
                prefixIconColor: Colors.white60,
                prefixIcon: Icon(Icons.person_outline, size: 16.sp),
              ),
            ),
            Obx(
              () => TextField(
                controller: controller.state.passwordController,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
                obscureText: controller.state.isObscure.value,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "请输入密码",
                  hintStyle: TextStyle(
                    color: Colors.white54,
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(Icons.lock_outline, size: 16.sp),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.toggleObscure();
                    },
                    icon: Icon(
                      controller.state.isObscure.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 16.sp,
                    ),
                  ),
                  prefixIconColor: Colors.white60,
                  suffixIconColor: Colors.white60,
                ),
              ),
            ),
            TextField(
              controller: controller.state.captchaController,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14.sp,
              ),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "请输入验证码",
                hintStyle: TextStyle(
                  color: Colors.white54,
                  fontSize: 14.sp,
                ),
                prefixIconColor: Colors.white60,
                prefixIcon: Icon(Icons.code, size: 16.sp),
                suffixIcon: GestureDetector(
                  onTap: controller.getCaptcha,
                  child: Obx(
                    () => controller.state.captcha.value.isEmpty
                        ? Image.asset(
                            'assets/images/empty_captcha.jpg',
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
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(double.maxFinite),
              ),
              onPressed: () {
                controller.login();
              },
              child: const Text(
                "登录",
                style: TextStyle(letterSpacing: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
