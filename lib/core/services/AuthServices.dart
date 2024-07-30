import 'package:eshop/core/models/UserDataModels.dart';
import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:eshop/presentation/auth/Widget/MyToast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (context.mounted) {
        context.read<UserDataProvider>().fetchUsers(userCredential.user!.uid);
      }
      return true;
    } on FirebaseAuthException catch (err) {
      shotToast(err.message.toString(), Colors.red);

      return false;
    }
  }

  Future<bool> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserData userData =
          UserData(email: email, id: cred.user!.uid, name: name);
      if (context.mounted) {
        context.read<UserDataProvider>().addUser(userData);
      }
      return true;
    } on FirebaseAuthException catch (err) {
      shotToast(err.toString(), Colors.red);
      return false;
    }
  }
}
