import 'package:flutter/material.dart';
import 'package:flutter_template/enums/upload_status_enum.dart';
import 'package:flutter_template/models/upload_file_model.dart';
import 'package:flutter_template/widgets/upload.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomeTabsHomePage extends GetView<HomeTabsHomeController> {
  const HomeTabsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: const UploadDemo(),
    );
  }
}

class UploadDemo extends StatefulWidget {
  const UploadDemo({super.key});

  @override
  UploadDemoState createState() => UploadDemoState();
}

class UploadDemoState extends State<UploadDemo> {
  List<UploadFileModel> uploadedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UploadComponent(
          fileList: uploadedFiles,
          action: 'http://example.com/upload',
          beforeUpload: (file) async {
            // 可以在这里进行文件类型检查等
            return true; // 返回 false 则停止上传
          },
          onChange: (files) {
            setState(() {
              uploadedFiles = files; // 更新已上传文件列表
            });
          },
          onRemove: (file) async {
            // 处理删除逻辑
            return true; // 返回 false 则不删除
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: uploadedFiles.length,
            itemBuilder: (context, index) {
              final file = uploadedFiles[index];
              return ListTile(
                title: Text(file.name),
                subtitle: Text('Status: ${file.status}'),
                trailing: file.status == UploadStatusEnum.done
                    ? Text('URL: ${file.url}')
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
