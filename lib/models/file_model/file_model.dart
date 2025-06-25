import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'file_model.freezed.dart';
part 'file_model.g.dart';

@freezed
abstract class FileModel with _$FileModel {
  const factory FileModel({
    @JsonKey(name: 'filePath') String? filePath,
    @JsonKey(name: 'fileName') String? fileName,
  }) = _FileModel;

  factory FileModel.fromJson(Map<String, Object?> json) =>
      _$FileModelFromJson(json);
}
