import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silvics/profile_page.dart';
import 'package:silvics/side_page/about_us.dart';
import 'package:silvics/side_page/gallery_page.dart';
import 'package:silvics/side_page/tutorials.dart';
import 'package:silvics/splash_screen.dart';

import '../services/services.dart';
import '../values/colors.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

var _iconColor = Colors.white;
var _textColor = TextStyle(color: AppColors.textWhite);

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.mainColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  DrawerHeader(
                      child: Column(
                    children: [
                      Container(
                        height: 14.h,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.person, color: _iconColor),
                      title: Text(
                        "Profile",
                        style: _textColor,
                      ),
                      onTap: () {
                        Get.to(() => ProfilePage());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading:
                      Icon(Icons.account_box_outlined, color: _iconColor),
                      title: Text(
                        "About US",
                        style: _textColor,
                      ),
                      onTap: (){
                        Get.to(()=> AboutUsPage());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.video_collection_outlined,
                          color: _iconColor),
                      title: Text(
                        "Tutorials",
                        style: _textColor,
                      ),
                      onTap: () {
                        Get.to(() => TutorialPage());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.photo, color: _iconColor),
                      title: Text(
                        "Gallery",
                        style: _textColor,
                      ),
                      onTap: () {
                        Get.to(() => GalleryPage());
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.thumb_up_sharp, color: _iconColor),
                      title: Text(
                        "Rate",
                        style: _textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.share, color: _iconColor),
                      title: Text(
                        "Share us",
                        style: _textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Icon(Icons.logout, color: _iconColor),
                      title: Text(
                        "Log out",
                        style: _textColor,
                      ),
                      onTap: () {
                        Services.showConfirmDialog(context, "Are You Sure ??",
                            () {
                          _logOut().then((value) {
                            Get.offAll(() => SplashScreen());
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _logOut() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }
}
