import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:eshop/presentation/auth/LoginScreen.dart';
import 'package:eshop/presentation/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);

    return FutureBuilder(
      future: userDataProvider.loadUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Column(
              children: [
                Text("E-shop"),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        } else {
          if (userDataProvider.users != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            });
          } else {
            // Navigate to Login Screen
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            });
          }
          return Container(); // This won't be visible as we're navigating away
        }
      },
    );
  }
}
