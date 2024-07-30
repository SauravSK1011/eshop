import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:eshop/presentation/category/CategoryScreen.dart';
import 'package:eshop/presentation/home/HomeScreen.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/widgets/mybottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "E-Shop",
            style: TextStyle(color: mainblue, fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer<UserDataProvider>(builder: (BuildContext context,
            UserDataProvider userdataprovider, Widget? child) {
          return Container(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(175),
                  child: Image.network(
                    userdataprovider.users!.image ??
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                    width: 175,
                    height: 175,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      userdataprovider.users!.name ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      userdataprovider.users!.email ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor: Color(0xff303F60),
                    ),
                    onPressed: () {},
                    child: const Padding(
                      padding:  EdgeInsets.all(15.0),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ))
              ],
            ),
          );
        }),
        bottomNavigationBar: MybottomNavigationBar(
          index: 2,
        ));
  }
}
