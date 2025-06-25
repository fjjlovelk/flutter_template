// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectModel implements DiagnosticableTreeMixin {

@JsonKey(name: 'valueData') String get valueData;@JsonKey(name: 'displayName') String get displayName;@JsonKey(name: 'codeValue') String? get codeValue;
/// Create a copy of SelectModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectModelCopyWith<SelectModel> get copyWith => _$SelectModelCopyWithImpl<SelectModel>(this as SelectModel, _$identity);

  /// Serializes this SelectModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SelectModel'))
    ..add(DiagnosticsProperty('valueData', valueData))..add(DiagnosticsProperty('displayName', displayName))..add(DiagnosticsProperty('codeValue', codeValue));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectModel&&(identical(other.valueData, valueData) || other.valueData == valueData)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.codeValue, codeValue) || other.codeValue == codeValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,valueData,displayName,codeValue);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SelectModel(valueData: $valueData, displayName: $displayName, codeValue: $codeValue)';
}


}

/// @nodoc
abstract mixin class $SelectModelCopyWith<$Res>  {
  factory $SelectModelCopyWith(SelectModel value, $Res Function(SelectModel) _then) = _$SelectModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'valueData') String valueData,@JsonKey(name: 'displayName') String displayName,@JsonKey(name: 'codeValue') String? codeValue
});




}
/// @nodoc
class _$SelectModelCopyWithImpl<$Res>
    implements $SelectModelCopyWith<$Res> {
  _$SelectModelCopyWithImpl(this._self, this._then);

  final SelectModel _self;
  final $Res Function(SelectModel) _then;

/// Create a copy of SelectModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? valueData = null,Object? displayName = null,Object? codeValue = freezed,}) {
  return _then(_self.copyWith(
valueData: null == valueData ? _self.valueData : valueData // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,codeValue: freezed == codeValue ? _self.codeValue : codeValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SelectModel with DiagnosticableTreeMixin implements SelectModel {
  const _SelectModel({@JsonKey(name: 'valueData') required this.valueData, @JsonKey(name: 'displayName') required this.displayName, @JsonKey(name: 'codeValue') this.codeValue});
  factory _SelectModel.fromJson(Map<String, dynamic> json) => _$SelectModelFromJson(json);

@override@JsonKey(name: 'valueData') final  String valueData;
@override@JsonKey(name: 'displayName') final  String displayName;
@override@JsonKey(name: 'codeValue') final  String? codeValue;

/// Create a copy of SelectModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectModelCopyWith<_SelectModel> get copyWith => __$SelectModelCopyWithImpl<_SelectModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SelectModel'))
    ..add(DiagnosticsProperty('valueData', valueData))..add(DiagnosticsProperty('displayName', displayName))..add(DiagnosticsProperty('codeValue', codeValue));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectModel&&(identical(other.valueData, valueData) || other.valueData == valueData)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.codeValue, codeValue) || other.codeValue == codeValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,valueData,displayName,codeValue);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SelectModel(valueData: $valueData, displayName: $displayName, codeValue: $codeValue)';
}


}

/// @nodoc
abstract mixin class _$SelectModelCopyWith<$Res> implements $SelectModelCopyWith<$Res> {
  factory _$SelectModelCopyWith(_SelectModel value, $Res Function(_SelectModel) _then) = __$SelectModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'valueData') String valueData,@JsonKey(name: 'displayName') String displayName,@JsonKey(name: 'codeValue') String? codeValue
});




}
/// @nodoc
class __$SelectModelCopyWithImpl<$Res>
    implements _$SelectModelCopyWith<$Res> {
  __$SelectModelCopyWithImpl(this._self, this._then);

  final _SelectModel _self;
  final $Res Function(_SelectModel) _then;

/// Create a copy of SelectModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? valueData = null,Object? displayName = null,Object? codeValue = freezed,}) {
  return _then(_SelectModel(
valueData: null == valueData ? _self.valueData : valueData // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,codeValue: freezed == codeValue ? _self.codeValue : codeValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
