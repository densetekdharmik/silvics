import 'package:flutter/material.dart';
import 'package:silvics/bottom_pages/contact_page.dart';
import 'package:silvics/bottom_pages/homepage.dart';
import 'package:silvics/bottom_pages/inquiry_page.dart';
import 'package:silvics/bottom_pages/tranding_page.dart';
import 'package:silvics/values/colors.dart';

import 'custom_widget/my_drawer.dart';

class ContainPage extends StatefulWidget {
  const ContainPage({Key? key}) : super(key: key);

  @override
  State<ContainPage> createState() => _ContainPageState();
}

int _currentIndex = 0;

List<Widget> pages = [
  HomePage(),
  TrandingPage(),
  InquireyPage(),
  ContactPage()
];

var _selectedIconColor = Colors.white;
var _unSelectedIconColor = Colors.white.withOpacity(0.4);
var _textStyle = TextStyle(color: AppColors.textWhite);

class _ContainPageState extends State<ContainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Center(
          child: pages[_currentIndex],
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: IndexedStack(
            index: _currentIndex,
            children: [
              Text(
                "Home",
                style: _textStyle,
              ),
              Text(
                "Trending",
                style: _textStyle,
              ),
              Text(
                "Inquiry",
                style: _textStyle,
              ),
              Text(
                "Contact",
                style: _textStyle,
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
          ],
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.white.withOpacity(0.6),
              labelTextStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: AppColors.textWhite))),
          child: NavigationBar(
            backgroundColor: AppColors.mainColor,
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: _unSelectedIconColor),
                selectedIcon: Icon(Icons.home, color: _selectedIconColor),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.trending_up, color: _unSelectedIconColor),
                selectedIcon:
                    Icon(Icons.trending_up, color: _selectedIconColor),
                label: "Trending",
              ),
              NavigationDestination(
                icon: Icon(Icons.question_mark_outlined,
                    color: _unSelectedIconColor),
                selectedIcon:
                    Icon(Icons.question_mark, color: _selectedIconColor),
                label: "Inquiry",
              ),
              NavigationDestination(
                icon: Icon(Icons.call_outlined, color: _unSelectedIconColor),
                selectedIcon: Icon(Icons.call, color: _selectedIconColor),
                label: "Contact",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
