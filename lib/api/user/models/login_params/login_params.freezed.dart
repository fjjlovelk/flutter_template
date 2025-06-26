// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginParams implements DiagnosticableTreeMixin {

@JsonKey(name: 'username') String get username;@JsonKey(name: 'password') String get password;@JsonKey(name: 'captcha') String get captcha;
/// Create a copy of LoginParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginParamsCopyWith<LoginParams> get copyWith => _$LoginParamsCopyWithImpl<LoginParams>(this as LoginParams, _$identity);

  /// Serializes this LoginParams to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginParams'))
    ..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('captcha', captcha));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginParams&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.captcha, captcha) || other.captcha == captcha));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,password,captcha);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginParams(username: $username, password: $password, captcha: $captcha)';
}


}

/// @nodoc
abstract mixin class $LoginParamsCopyWith<$Res>  {
  factory $LoginParamsCopyWith(LoginParams value, $Res Function(LoginParams) _then) = _$LoginParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'username') String username,@JsonKey(name: 'password') String password,@JsonKey(name: 'captcha') String captcha
});




}
/// @nodoc
class _$LoginParamsCopyWithImpl<$Res>
    implements $LoginParamsCopyWith<$Res> {
  _$LoginParamsCopyWithImpl(this._self, this._then);

  final LoginParams _self;
  final $Res Function(LoginParams) _then;

/// Create a copy of LoginParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? password = null,Object? captcha = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,captcha: null == captcha ? _self.captcha : captcha // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _LoginParams with DiagnosticableTreeMixin implements LoginParams {
  const _LoginParams({@JsonKey(name: 'username') required this.username, @JsonKey(name: 'password') required this.password, @JsonKey(name: 'captcha') required this.captcha});
  factory _LoginParams.fromJson(Map<String, dynamic> json) => _$LoginParamsFromJson(json);

@override@JsonKey(name: 'username') final  String username;
@override@JsonKey(name: 'password') final  String password;
@override@JsonKey(name: 'captcha') final  String captcha;

/// Create a copy of LoginParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginParamsCopyWith<_LoginParams> get copyWith => __$LoginParamsCopyWithImpl<_LoginParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginParamsToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LoginParams'))
    ..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('password', password))..add(DiagnosticsProperty('captcha', captcha));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginParams&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password)&&(identical(other.captcha, captcha) || other.captcha == captcha));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,password,captcha);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LoginParams(username: $username, password: $password, captcha: $captcha)';
}


}

/// @nodoc
abstract mixin class _$LoginParamsCopyWith<$Res> implements $LoginParamsCopyWith<$Res> {
  factory _$LoginParamsCopyWith(_LoginParams value, $Res Function(_LoginParams) _then) = __$LoginParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'username') String username,@JsonKey(name: 'password') String password,@JsonKey(name: 'captcha') String captcha
});




}
/// @nodoc
class __$LoginParamsCopyWithImpl<$Res>
    implements _$LoginParamsCopyWith<$Res> {
  __$LoginParamsCopyWithImpl(this._self, this._then);

  final _LoginParams _self;
  final $Res Function(_LoginParams) _then;

/// Create a copy of LoginParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? password = null,Object? captcha = null,}) {
  return _then(_LoginParams(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,captcha: null == captcha ? _self.captcha : captcha // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
