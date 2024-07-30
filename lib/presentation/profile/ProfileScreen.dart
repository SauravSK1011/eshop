import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:eshop/presentation/splash%20screen/SplashScreen.dart';
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
            "Profile",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
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
                Column(
                  children: [
                    Text(
                      userdataprovider.users!.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      userdataprovider.users!.email,
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
                    onPressed: () async{
                     await context.read<UserDataProvider>().deletuserdata();
                    if(context.mounted){  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SplashScreen()));}
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
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
