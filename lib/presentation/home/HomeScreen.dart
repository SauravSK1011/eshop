import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserDataProvider>(
        builder: (BuildContext context, UserDataProvider value, Widget? child) {
          return Center(child: Text(value.users!.email));
        },
      ),
    );
  }
}
