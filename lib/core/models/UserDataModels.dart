class UserData {
  String id;
  String name;
  String email;
  String? image;

  List<Map<String, dynamic>>? orders;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.orders,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      image: map['phoneNumber'],
      orders: map['orders'] != null
          ? List<Map<String, dynamic>>.from(map['orders'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'orders': orders,
    };
  }
}
