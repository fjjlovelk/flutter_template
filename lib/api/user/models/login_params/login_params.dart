import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'login_params.freezed.dart';
part 'login_params.g.dart';

@freezed
abstract class LoginParams with _$LoginParams {
  const factory LoginParams({
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'password') required String password,
    @JsonKey(name: 'captcha') required String captcha,
  }) = _LoginParams;

  factory LoginParams.fromJson(Map<String, Object?> json) =>
      _$LoginParamsFromJson(json);
}
