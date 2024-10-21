import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/http/http_service.dart';
import 'package:flutter_template/models/file_model.dart';
import 'package:flutter_template/models/user_model.dart';

class UserApi {
  /// 获取验证码
  static Future<String> getCaptchaApi(int data) async {
    var response = await HttpService().get("/sys/randomImage/$data");
    return response['result'] ?? "";
  }

  /// 登录
  static Future<UserModel> loginApi(Map<String, dynamic> data) async {
    var response = await HttpService().post('/sys/mLogin', data: data);
    return UserModel.fromJson(response?['result'] ?? json.encode({}));
  }

  /// 退出登录
  static Future<void> logout() async {
    return HttpService().post('/sys/logout');
  }

  /// 文件上传
  static Future<FileModel> upload(
    Map<String, dynamic> data, {
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    var response = await HttpService().postForm(
      '/upload/single',
      data: data,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
    return FileModel.fromJson(response ?? json.encode({}));
  }
}
