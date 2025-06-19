import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.token,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? token,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        token: token ?? this.token,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "token": token,
      };
}
