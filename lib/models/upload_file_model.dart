import 'package:flutter_template/enums/upload_status_enum.dart';
import 'package:uuid/uuid.dart';

/// 上传文件 model
class UploadFileModel {
  /// 文件名
  String name;

  /// 已上传文件的 url
  String? url;

  /// 文件的本地路径
  String? localPath;

  /// 上传进度
  double percent;

  /// 上传状态
  UploadStatusEnum status;

  /// 文件唯一标识，一般用 uuid 生成
  String uid;

  UploadFileModel({
    required this.name,
    this.url,
    this.localPath,
    this.percent = 0,
    this.status = UploadStatusEnum.ready,
    String? uid,
  }) : uid = uid ?? const Uuid().v4();
}
