import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

enum UploadStatus { ready, uploading, done, error }

class UploadFile {
  String name;
  String? url;
  String? localPath;
  double percent;
  UploadStatus status;
  String uid;

  UploadFile({
    required this.name,
    this.url,
    this.localPath,
    this.percent = 0,
    this.status = UploadStatus.ready,
    String? uid,
  }) : uid = uid ?? const Uuid().v4(); // 使用 uuid 生成唯一的 uid
}

class UploadComponent extends StatefulWidget {
  final List<UploadFile>? fileList;
  final String? action;
  final bool disabled;
  final int maxCount;
  final Future<bool> Function(UploadFile)? beforeUpload;
  final Future<void> Function(UploadFile)? customRequest;
  final Function(List<UploadFile>)? onChange;
  final Future<bool> Function(UploadFile)? onRemove;
  final bool multiple;

  const UploadComponent({
    super.key,
    this.fileList,
    this.action,
    this.disabled = false,
    this.maxCount = 5,
    this.beforeUpload,
    this.customRequest,
    this.onChange,
    this.onRemove,
    this.multiple = false,
  });

  @override
  UploadComponentState createState() => UploadComponentState();
}

class UploadComponentState extends State<UploadComponent> {
  ValueNotifier<List<UploadFile>> filesNotifier = ValueNotifier([]);
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.fileList != null) {
      filesNotifier.value = widget.fileList!;
    }
  }

  Future<void> _pickFiles() async {
    if (widget.disabled) return;

    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isEmpty) {
      return;
    }
    int currentCount = filesNotifier.value.length;

    if (widget.maxCount > 0 &&
        (currentCount + pickedFiles.length) > widget.maxCount) {
      // 提示用户选择的文件超出最大数量
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('选择的文件超过最大数量限制，最多可选择 ${widget.maxCount} 个文件。')),
      );
      return; // 直接返回，不继续上传
    }

    for (var pickedFile in pickedFiles) {
      final uploadFile = UploadFile(
        name: pickedFile.name,
        localPath: pickedFile.path,
        uid: const Uuid().v4(),
      );

      if (widget.beforeUpload != null) {
        final shouldUpload = await widget.beforeUpload!(uploadFile);
        if (!shouldUpload) continue;
      }

      _uploadFile(uploadFile);
      filesNotifier.value = List.from(filesNotifier.value)..add(uploadFile);
    }
  }

  Future<void> _uploadFile(UploadFile uploadFile) async {
    uploadFile.status = UploadStatus.uploading;

    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 200));
      uploadFile.percent = i / 100;
      filesNotifier.value = List.from(filesNotifier.value);
    }

    uploadFile.status = UploadStatus.done;
    uploadFile.url = 'http://example.com/${uploadFile.name}';
    filesNotifier.value = List.from(filesNotifier.value);
  }

  Future<void> _removeFile(UploadFile uploadFile) async {
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
    return ValueListenableBuilder<List<UploadFile>>(
      valueListenable: filesNotifier,
      builder: (context, files, child) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: files.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < files.length) {
              final file = files[index];
              return UploadItem(
                key: ValueKey(file.uid),
                file: file,
                onRemove: () => _removeFile(file),
              );
            }
            return GestureDetector(
              onTap: _pickFiles,
              child: Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 40),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
