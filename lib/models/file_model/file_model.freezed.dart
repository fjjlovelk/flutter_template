// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileModel implements DiagnosticableTreeMixin {

@JsonKey(name: 'filePath') String? get filePath;@JsonKey(name: 'fileName') String? get fileName;
/// Create a copy of FileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileModelCopyWith<FileModel> get copyWith => _$FileModelCopyWithImpl<FileModel>(this as FileModel, _$identity);

  /// Serializes this FileModel to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FileModel'))
    ..add(DiagnosticsProperty('filePath', filePath))..add(DiagnosticsProperty('fileName', fileName));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileModel&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filePath,fileName);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FileModel(filePath: $filePath, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class $FileModelCopyWith<$Res>  {
  factory $FileModelCopyWith(FileModel value, $Res Function(FileModel) _then) = _$FileModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'filePath') String? filePath,@JsonKey(name: 'fileName') String? fileName
});




}
/// @nodoc
class _$FileModelCopyWithImpl<$Res>
    implements $FileModelCopyWith<$Res> {
  _$FileModelCopyWithImpl(this._self, this._then);

  final FileModel _self;
  final $Res Function(FileModel) _then;

/// Create a copy of FileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filePath = freezed,Object? fileName = freezed,}) {
  return _then(_self.copyWith(
filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FileModel with DiagnosticableTreeMixin implements FileModel {
  const _FileModel({@JsonKey(name: 'filePath') this.filePath, @JsonKey(name: 'fileName') this.fileName});
  factory _FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);

@override@JsonKey(name: 'filePath') final  String? filePath;
@override@JsonKey(name: 'fileName') final  String? fileName;

/// Create a copy of FileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileModelCopyWith<_FileModel> get copyWith => __$FileModelCopyWithImpl<_FileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileModelToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FileModel'))
    ..add(DiagnosticsProperty('filePath', filePath))..add(DiagnosticsProperty('fileName', fileName));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileModel&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileName, fileName) || other.fileName == fileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filePath,fileName);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FileModel(filePath: $filePath, fileName: $fileName)';
}


}

/// @nodoc
abstract mixin class _$FileModelCopyWith<$Res> implements $FileModelCopyWith<$Res> {
  factory _$FileModelCopyWith(_FileModel value, $Res Function(_FileModel) _then) = __$FileModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'filePath') String? filePath,@JsonKey(name: 'fileName') String? fileName
});




}
/// @nodoc
class __$FileModelCopyWithImpl<$Res>
    implements _$FileModelCopyWith<$Res> {
  __$FileModelCopyWithImpl(this._self, this._then);

  final _FileModel _self;
  final $Res Function(_FileModel) _then;

/// Create a copy of FileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filePath = freezed,Object? fileName = freezed,}) {
  return _then(_FileModel(
filePath: freezed == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
