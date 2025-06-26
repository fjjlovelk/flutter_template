import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_template/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../utils/logger_util.dart';

class PermissionUtil {
  static Future<bool> _requestPermission(
      Permission permission, String message) async {
    PermissionStatus status = await permission.status;
    LoggerUtil.info('PermissionStatus---->$status}');
    // 允许/限制性允许
    if (status.isGranted || status.isLimited) {
      return true;
    }
    // 已拒绝
    if (status.isDenied) {
      // 重新请求
      PermissionStatus permissionStatus = await permission.request();
      if (permissionStatus.isGranted || permissionStatus.isLimited) {
        return true;
      }
      // 永久拒绝或拒绝弹框提示
      if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
        ToastUtil.warning(message);
        return false;
      }
      return false;
    }
    // 永久拒绝
    if (status.isPermanentlyDenied) {
      ToastUtil.warning(message);
      return false;
    }
    return false;
  }

  /// 相册 权限检查和请求
  static Future<bool> photos({String message = '暂无相册权限，请前往设置开启权限'}) async {
    // try {
    //   await AssetPicker.permissionCheck();
    //   return true;
    // } catch (e) {
    //   return false;
    // }
    Permission permission = Permission.photos;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        permission = Permission.storage;
      }
    }
    bool isGranted = await _requestPermission(permission, message);
    return isGranted;
  }

  /// 相机 权限检查和请求
  static Future<bool> camera({String message = '暂无相机权限，请前往设置开启权限'}) =>
      _requestPermission(Permission.camera, message);

  /// 麦克风 权限检查和请求
  static Future<bool> microphone({String message = '暂无麦克风权限，请前往设置开启权限'}) =>
      _requestPermission(Permission.microphone, message);

  /// 手机存储 权限检查和请求
  static Future<bool> storage({String message = '暂无手机存储权限，请前往设置开启权限'}) =>
      _requestPermission(Permission.storage, message);

  /// 媒体位置权限
  static Future<bool> accessMediaLocation(
          {String message = '暂无媒体位置权限，请前往设置开启权限'}) =>
      _requestPermission(Permission.accessMediaLocation, message);
}
