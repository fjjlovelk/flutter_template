import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'select_model.freezed.dart';
part 'select_model.g.dart';

@freezed
abstract class SelectModel with _$SelectModel {
  const factory SelectModel({
    @JsonKey(name: 'valueData') required String valueData,
    @JsonKey(name: 'displayName') required String displayName,
    @JsonKey(name: 'codeValue') String? codeValue,
  }) = _SelectModel;

  factory SelectModel.fromJson(Map<String, Object?> json) =>
      _$SelectModelFromJson(json);
}
