// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? firstName;
  int? age;
  String? email;
  String? lastName;
  String? uId;

  UserModel({
    this.firstName,
    this.age,
    this.email,
    this.lastName,
    this.uId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["First Name"],
        age: json["age"],
        email: json["email"],
        lastName: json["last Name"],
        uId: json["uID"],
      );

  Map<String, dynamic> toJson() => {
        "First Name": firstName,
        "age": age,
        "email": email,
        "last Name": lastName,
        "uID": uId,
      };
}
