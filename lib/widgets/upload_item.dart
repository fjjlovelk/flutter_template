import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/enums/upload_status_enum.dart';
import 'package:flutter_template/models/upload_file_model.dart';

class UploadItem extends StatelessWidget {
  /// 上传的文件
  final UploadFileModel file;

  /// 盒子大小，默认80
  final double boxSize;

  /// 长按文件
  final Future<void> Function(UploadFileModel)? onLongPress;

  const UploadItem({
    super.key,
    required this.file,
    this.onLongPress,
    this.boxSize = 80,
  });

  /// 显示的图片
  Widget _buildImage() {
    if (file.localPath != null) {
      return Image.file(File(file.localPath!), fit: BoxFit.cover);
    }
    if (file.url != null) {
      Image.network(file.url!, fit: BoxFit.cover);
    }
    return Text(UploadStatusEnum.error.desc);
  }

  /// 上传进度条
  Widget _buildProgress() {
    switch (file.status) {
      case UploadStatusEnum.ready:
      case UploadStatusEnum.uploading:
        return SizedBox(
          width: 20.r,
          height: 20.r,
          child: CircularProgressIndicator(
            value: file.percent,
            color: Colors.blue,
            strokeWidth: 10.r,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        );
      case UploadStatusEnum.error:
        return Icon(
          Icons.info_rounded,
          color: Colors.red,
          size: 20.r,
        );
      case UploadStatusEnum.done:
        return Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20.r,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('UploadItem--build---${file.uid}');
    return InkWell(
      onLongPress: () {
        onLongPress?.call(file);
      },
      borderRadius: BorderRadius.circular(8.r),
      child: SizedBox(
        width: boxSize.r,
        height: boxSize.r,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(),
              Positioned(
                top: 0,
                right: 0,
                child: _buildProgress(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
