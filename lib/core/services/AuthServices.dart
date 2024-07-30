import 'package:eshop/core/models/UserDataModels.dart';
import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:eshop/presentation/auth/Widget/MyToast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> loginUser({    required BuildContext context,

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
      print(userCredential.user!.email);
    } on FirebaseAuthException catch (err) {
      print(err);
      shotToast(err.toString(), Colors.red);
    }
  }

  Future<void> signUpUser({
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
    } on FirebaseAuthException catch (err) {
      shotToast(err.toString(), Colors.red);
    }
  }
}
