import 'package:eshop/core/models/UserDataModels.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'users';

  UserData? _users;

  UserData? get users => _users;

  UserDataProvider() {
  }

  Future<UserData?> fetchUsers(String id) async {
    
    print("object");
    try {
        QuerySnapshot snapshot = await _firestore.collection(collectionName).get();
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['id'] == id) {
          _users = UserData.fromMap(data);
          break;
        }
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching users: $e');
    }
    return null;
  }

  Future<void> addUser(UserData userData) async {
    try {
      await _firestore.collection(collectionName).add(userData.toMap());
      fetchUsers(userData.id);
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  Future<void> updateUser(String id, UserData userData) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(id)
          .update(userData.toMap());
      fetchUsers(userData.id);
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection(collectionName).doc(id).delete();
      fetchUsers(id);
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
