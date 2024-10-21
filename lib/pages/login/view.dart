import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildForm(),
    );
  }

  /// 表单区域
  Widget _buildForm() {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return SizedBox(
            width: constraint.maxWidth * 4 / 5,
            child: Column(
              children: [
                TextField(
                  controller: controller.state.usernameController,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: "请输入账号",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.sp,
                    ),
                    prefixIconColor: Colors.white60,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                TextField(
                  controller: controller.state.passwordController,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: "请输入密码",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.sp,
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    // suffixIcon: IconButton(
                    //   onPressed: () {
                    //     controller.toggleObscure();
                    //   },
                    //   icon: Icon(
                    //     controller.state.isObscure.value
                    //         ? Icons.visibility_outlined
                    //         : Icons.visibility_off_outlined,
                    //     size: 20.sp,
                    //   ),
                    // ),
                    prefixIconColor: Colors.white60,
                    suffixIconColor: Colors.white60,
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.login();
                    },
                    child: const Text(
                      "登录",
                      style: TextStyle(letterSpacing: 5),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
