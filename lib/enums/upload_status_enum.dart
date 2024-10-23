enum UploadStatusEnum {
  ready('准备上传'),
  uploading('上传中'),
  done('上传完成'),
  error('上传失败');

  const UploadStatusEnum(this.desc);
  final String desc;
}
