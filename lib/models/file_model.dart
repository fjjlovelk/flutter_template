import 'dart:convert';

class FileModel {
  String? filePath;
  String? fileName;

  FileModel({
    this.filePath,
    this.fileName,
  });

  FileModel copyWith({
    String? filePath,
    String? fileName,
  }) =>
      FileModel(
        filePath: filePath ?? this.filePath,
        fileName: fileName ?? this.fileName,
      );

  factory FileModel.fromRawJson(String str) =>
      FileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        filePath: json["filePath"],
        fileName: json["fileName"],
      );

  Map<String, dynamic> toJson() => {
        "filePath": filePath,
        "fileName": fileName,
      };
}
