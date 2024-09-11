import 'dart:convert';

AuthResponse authResponseFromJson(Map<String, dynamic> json) =>
    AuthResponse.fromJson(json);

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  final String? id;
  final String? username;
  final String? token;

  AuthResponse({
    this.id,
    this.username,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        id: json["_id"],
        username: json["username"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "token": token,
      };
}
