import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../config/theme_config.dart';

enum UploadStatusEnum {
  ready('准备上传'),
  uploading('上传中'),
  done('上传完成'),
  error('上传失败');

  /// 描述
  final String desc;

  const UploadStatusEnum(this.desc);
}

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

/// Upload中的加号
class UploadSelect extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  /// 盒子大小，默认80
  final double boxSize;

  /// 选择图片数量，-1为无限制，默认9张
  final int maxCount;

  /// 已选图片数量
  final int selectedCount;

  /// 是否允许多选
  final bool multiple;

  /// 选择图片后触发的回调
  final void Function(List<UploadFileModel>) onSelect;

  UploadSelect({
    super.key,
    this.boxSize = 80,
    this.maxCount = 9,
    required this.onSelect,
    required this.selectedCount,
    this.multiple = true,
  });

  /// 点击事件
  void onTap(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => onSelectPhoto(context),
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
  void onSelectPhoto(BuildContext context) async {
    Get.back();
    int limit = maxCount;
    if (multiple == false) {
      limit = 1;
    } else if (maxCount != -1) {
      int remainingCount = maxCount - selectedCount;
      limit = remainingCount >= 0 ? remainingCount : 0;
    }
    final List<AssetEntity>? pickedFiles = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: limit,
        textDelegate: const AssetPickerTextDelegate(),
      ),
    );
    if (pickedFiles == null) {
      return;
    }
    final List<UploadFileModel> result = [];
    for (var pickedFile in pickedFiles) {
      File? file = await pickedFile.file;
      if (file == null) {
        continue;
      }
      final uploadFile = UploadFileModel(
        name: pickedFile.title ?? '',
        localPath: file.path,
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
      splashColor: Colors.black.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(ThemeConfig.radius),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(ThemeConfig.radius),
        ),
        child: Icon(
          Icons.add,
          size: (boxSize / 3).truncateToDouble().r,
          color: Colors.black.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

/// upload每一项
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
    return InkWell(
      onLongPress: () {
        onLongPress?.call(file);
      },
      borderRadius: BorderRadius.circular(ThemeConfig.radius),
      child: SizedBox(
        width: boxSize.r,
        height: boxSize.r,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ThemeConfig.radius),
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

/// 上传组件
class Upload extends StatefulWidget {
  /// 已上传的文件列表，结合 onChange 实现可控组件
  final List<UploadFileModel> fileList;

  /// 上传接口路径
  final String? action;

  /// 是否禁用
  final bool disabled;

  /// 最大选择数量
  final int maxCount;

  /// 是否允许多选
  final bool multiple;

  /// 文件上传前操作
  final Future<bool> Function(UploadFileModel)? beforeUpload;

  /// 自定义上传
  final Future<void> Function(UploadFileModel)? customRequest;

  /// 在文件选择、上传、成功、失败时都会调用，结合 fileList 可实现可控组件
  final Function(List<UploadFileModel>)? onChange;

  /// 移除文件
  final Future<bool> Function(UploadFileModel)? onRemove;

  const Upload({
    super.key,
    this.fileList = const [],
    this.action,
    this.disabled = false,
    this.maxCount = 9,
    this.multiple = true,
    this.beforeUpload,
    this.customRequest,
    this.onChange,
    this.onRemove,
  });

  @override
  UploadState createState() => UploadState();
}

class UploadState extends State<Upload> {
  final ValueNotifier<List<UploadFileModel>> _filesNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    if (widget.fileList.isNotEmpty) {
      _filesNotifier.value = widget.fileList;
    }
  }

  @override
  void dispose() {
    _filesNotifier.dispose();
    super.dispose();
  }

  /// 选择图片
  void _onSelect(List<UploadFileModel> selectedFiles) async {
    for (var selectedFile in selectedFiles) {
      if (widget.beforeUpload != null) {
        final shouldUpload = await widget.beforeUpload!(selectedFile);
        if (!shouldUpload) continue;
      }
      _filesNotifier.value = List.from(_filesNotifier.value)..add(selectedFile);
      widget.onChange?.call(_filesNotifier.value);
      _uploadFile(selectedFile);
    }
  }

  /// 上传文件
  Future<void> _uploadFile(UploadFileModel uploadFile) async {
    uploadFile.status = UploadStatusEnum.uploading;
    _filesNotifier.value = List.from(_filesNotifier.value);
    widget.onChange?.call(_filesNotifier.value);

    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      uploadFile.percent = i / 100;
      _filesNotifier.value = List.from(_filesNotifier.value);
    }

    uploadFile.status = UploadStatusEnum.done;
    uploadFile.url = uploadFile.name;
    _filesNotifier.value = List.from(_filesNotifier.value);
    widget.onChange?.call(_filesNotifier.value);
  }

  /// 移除文件
  Future<void> _removeFile(UploadFileModel uploadFile) async {
    if (widget.onRemove != null) {
      final shouldRemove = await widget.onRemove!(uploadFile);
      if (!shouldRemove) return;
    }
    _filesNotifier.value = _filesNotifier.value
        .where((file) => file.uid != uploadFile.uid)
        .toList();
    widget.onChange?.call(_filesNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UploadFileModel>>(
      valueListenable: _filesNotifier,
      child: UploadSelect(
        maxCount: widget.maxCount,
        onSelect: _onSelect,
        selectedCount: _filesNotifier.value.length,
        multiple: widget.multiple,
      ),
      builder: (context, files, child) {
        bool notShowSelect = files.length >= widget.maxCount || widget.disabled;
        return GridView.builder(
          padding: EdgeInsets.all(ThemeConfig.miniPadding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 8.r,
            crossAxisSpacing: 8.r,
          ),
          itemCount: files.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < files.length) {
              final file = files[index];
              return UploadItem(
                key: ObjectKey(file.uid),
                file: file,
                onLongPress: widget.disabled ? null : _removeFile,
              );
            }
            return notShowSelect ? null : child;
          },
        );
      },
    );
  }
}
