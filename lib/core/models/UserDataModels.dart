import 'dart:convert';

class UserData {
  String id;
  String name;
  String email;
  UserData({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
