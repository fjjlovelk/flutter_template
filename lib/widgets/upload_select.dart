import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/models/upload_file_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

/// Upload中的加号
class UploadSelect extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  /// 盒子大小，默认80
  final double boxSize;

  /// 选择图片数量，-1为无限制，默认9张
  final int maxCount;

  /// 已选图片数量
  final int selectedCount;

  /// 选择图片后触发的回调
  final void Function(List<UploadFileModel>) onSelect;

  UploadSelect({
    super.key,
    this.boxSize = 80,
    this.maxCount = 9,
    required this.onSelect,
    required this.selectedCount,
  });

  /// 点击事件
  void onTap(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => onSelectPhoto(),
            child:
                maxCount == -1 ? const Text('图片') : Text('图片 (最多$maxCount张)'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => onSelectCamera(),
            child: const Text('拍照'),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: onSelectCancel,
          child: const Text('取消'),
        ),
      ),
    );
  }

  /// 选择图片
  void onSelectPhoto() async {
    Get.back();
    final List<XFile> pickedFiles = await _picker.pickMultiImage(
      limit: maxCount == -1 ? 99 : (maxCount - selectedCount),
    );
    if (pickedFiles.isEmpty) {
      return;
    }
    final List<UploadFileModel> result = [];
    for (var pickedFile in pickedFiles) {
      final uploadFile = UploadFileModel(
        name: pickedFile.name,
        localPath: pickedFile.path,
        uid: const Uuid().v4(),
      );
      result.add(uploadFile);
    }
    onSelect(result);
  }

  /// 选择拍照
  void onSelectCamera() async {
    Get.back();
    // 调用拍照
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      return;
    }
    final uploadFile = UploadFileModel(
      name: photo.name,
      localPath: photo.path,
      uid: const Uuid().v4(),
    );
    onSelect([uploadFile]);
  }

  /// 取消
  void onSelectCancel() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      splashColor: Colors.black.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.add,
          size: (boxSize / 3).truncateToDouble().r,
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}
