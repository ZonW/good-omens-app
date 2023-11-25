// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {required this.id,
      required this.email,
      required this.phoneNumber,
      required this.subscription,
      required this.subscription_time,
      required this.theme,
      required this.book,
      required this.language,
      required this.reminder});

  String id;
  String email;
  String phoneNumber;
  String book;
  String language;
  String reminder;
  int subscription;
  String subscription_time;
  int theme;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        book: json["book"],
        language: json["language"],
        reminder: json["reminder"],
        theme: json["theme"],
        subscription: json["subscription"],
        subscription_time: json["subscription_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone_number": phoneNumber,
        "book": book,
        "language": language,
        "reminder": reminder,
        "theme": theme,
        "subscription": subscription,
        "subscription_time": subscription_time,
      };
}
