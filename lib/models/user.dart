// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickName,
    required this.email,
    required this.phoneNumber,
    required this.collection,
    required this.subscription,
  });

  String id;
  String firstName;
  String lastName;
  String nickName;
  String email;
  String phoneNumber;
  List<String> collection;
  int subscription;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nickName: json["nick_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        collection: json["collection"] == null
            ? []
            : List<String>.from(json["collection"]!.map((x) => x)),
        subscription: json["subscription"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "nick_name": nickName,
        "email": email,
        "phone_number": phoneNumber,
        "collection": List<String>.from(collection.map((x) => x)),
        "subscription": subscription,
      };
}
