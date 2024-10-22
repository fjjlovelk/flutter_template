import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/widgets/upload.dart';

class UploadItem extends StatelessWidget {
  final UploadFile file;

  /// 盒子大小，默认80
  final double boxSize;

  final Future<void> Function() onRemove;

  UploadItem({
    Key? key,
    required this.file,
    required this.onRemove,
    required this.boxSize,
  }) : super(key: ValueKey(file.uid)); // 使用 ValueKey

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 100.r,
          height: 100.r,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            image: file.localPath != null
                ? DecorationImage(
                    image: FileImage(File(file.localPath!)), fit: BoxFit.cover)
                : (file.status == UploadStatus.done && file.url != null)
                    ? DecorationImage(
                        image: NetworkImage(file.url!), fit: BoxFit.cover)
                    : null,
          ),
          child: file.status == UploadStatus.uploading
              ? Center(child: CircularProgressIndicator(value: file.percent))
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: onRemove,
        ),
      ],
    );
  }
}
