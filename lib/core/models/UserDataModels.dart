class UserData {
  String id;
  String name;
  String email;
  String? phoneNumber;
  String? address;
  List<Map<String, dynamic>>? orders;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
    this.orders,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      orders: map['orders'] != null ? List<Map<String, dynamic>>.from(map['orders']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'orders': orders,
    };
  }
}
