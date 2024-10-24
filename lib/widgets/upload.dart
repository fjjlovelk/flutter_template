import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/enums/upload_status_enum.dart';
import 'package:flutter_template/models/upload_file_model.dart';
import 'package:flutter_template/widgets/upload_item.dart';
import 'package:flutter_template/widgets/upload_select.dart';

class UploadComponent extends StatefulWidget {
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

  const UploadComponent({
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
  UploadComponentState createState() => UploadComponentState();
}

class UploadComponentState extends State<UploadComponent> {
  ValueNotifier<List<UploadFileModel>> filesNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    if (widget.fileList.isNotEmpty) {
      filesNotifier.value = widget.fileList;
    }
  }

  /// 选择图片
  void _onSelect(List<UploadFileModel> selectedFiles) async {
    for (var selectedFile in selectedFiles) {
      if (widget.beforeUpload != null) {
        final shouldUpload = await widget.beforeUpload!(selectedFile);
        if (!shouldUpload) continue;
      }
      filesNotifier.value = List.from(filesNotifier.value)..add(selectedFile);
      widget.onChange?.call(filesNotifier.value);
      _uploadFile(selectedFile);
    }
  }

  /// 上传文件
  Future<void> _uploadFile(UploadFileModel uploadFile) async {
    uploadFile.status = UploadStatusEnum.uploading;
    filesNotifier.value = List.from(filesNotifier.value);
    widget.onChange?.call(filesNotifier.value);

    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      uploadFile.percent = i / 100;
      filesNotifier.value = List.from(filesNotifier.value);
    }

    uploadFile.status = UploadStatusEnum.done;
    uploadFile.url = uploadFile.name;
    filesNotifier.value = List.from(filesNotifier.value);
    widget.onChange?.call(filesNotifier.value);
  }

  /// 移除文件
  Future<void> _removeFile(UploadFileModel uploadFile) async {
    if (widget.onRemove != null) {
      final shouldRemove = await widget.onRemove!(uploadFile);
      if (!shouldRemove) return;
    }
    filesNotifier.value = filesNotifier.value
        .where((file) => file.uid != uploadFile.uid)
        .toList();
    widget.onChange?.call(filesNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<UploadFileModel>>(
      valueListenable: filesNotifier,
      child: UploadSelect(
        maxCount: widget.maxCount,
        onSelect: _onSelect,
        selectedCount: filesNotifier.value.length,
        multiple: widget.multiple,
      ),
      builder: (context, files, child) {
        bool notShowSelect = files.length >= widget.maxCount || widget.disabled;
        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 8.r,
            vertical: 8.r,
          ),
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
