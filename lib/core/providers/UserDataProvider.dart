import 'package:eshop/core/models/UserDataModels.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'users';

  UserData? _users;

  UserData? get users => _users;

  UserDataProvider() {
    loadUserData();
  }
  loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      _users = UserData.fromJson(userDataString);
      notifyListeners();
    }
  }

  saveuser(UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userData", userData.toJson());
  }

  deletuserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
    _users=null;
    
  }

  Future<UserData?> fetchUsers(String id) async {
    print("object");
    try {
      QuerySnapshot snapshot =
          await _firestore.collection(collectionName).get();
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        if (data['id'] == id) {
          _users = UserData.fromMap(data);
          saveuser(_users!);

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


}
