import 'dart:convert';

class SelectModel {
  final String valueData;
  final String displayName;
  final String? codeValue;

  SelectModel({
    required this.valueData,
    required this.displayName,
    this.codeValue,
  });

  SelectModel copyWith({
    String? valueData,
    String? displayName,
    String? codeValue,
  }) =>
      SelectModel(
        valueData: valueData ?? this.valueData,
        displayName: displayName ?? this.displayName,
        codeValue: codeValue ?? this.codeValue,
      );

  factory SelectModel.fromRawJson(String str) =>
      SelectModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectModel.fromJson(Map<String, dynamic> json) => SelectModel(
        valueData: json["valueData"] ?? '',
        displayName: json["displayName"] ?? '',
        codeValue: json["codeValue"],
      );

  Map<String, dynamic> toJson() => {
        "valueData": valueData,
        "displayName": displayName,
        "codeValue": codeValue,
      };
}
