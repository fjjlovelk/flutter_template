import 'dart:convert';

import 'package:dio/dio.dart';

import '../http/http_service.dart';
import '../models/file_model.dart';
import '../models/user_model.dart';

class UserApi {
  /// 获取验证码
  static Future<String> getCaptchaApi() async {
    var response = await HttpService().get("/sys/randomImage");
    return response['result'] ?? "";
  }

  /// 登录
  static Future<UserModel> loginApi(Map<String, dynamic> data) async {
    // var response = await HttpService().post('/sys/mLogin', data: data);
    // return UserModel.fromJson(response?['result'] ?? json.encode({}));
    UserModel userModel = UserModel(id: '111', name: '222', token: '333');
    return userModel;
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
