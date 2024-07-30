import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eshop/presentation/category/CategoryScreen.dart';
import 'package:eshop/presentation/home/HomeScreen.dart';
import 'package:eshop/presentation/profile/ProfileScreen.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';

class MybottomNavigationBar extends StatelessWidget {
  MybottomNavigationBar({super.key, this.index = 0});
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      backgroundColor: mainblue,
      color: Colors.white,
      items: <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.category, size: 30),
        Icon(Icons.person, size: 30),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (index == 1) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => CategoryScreen()));
        } else if (index == 2) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        }
      },
    );
  }
}
