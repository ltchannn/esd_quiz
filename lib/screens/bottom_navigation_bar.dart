import 'package:esdlife_quiz/screens/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/screens/home.dart';
import '/screens/about_us.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      //body: screens[currentIndex],
      //backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
          activeColor: Colors.red[800], 
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset('assets/home_icon(default).png'),
              activeIcon: Image.asset('assets/home_home(active).png'),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/home_todo(default).png'),
              activeIcon: Image.asset('assets/home_todo(active).png'),
              label: 'To Do',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/home_about us(default).png'),
              activeIcon: Image.asset('assets/home_about us(active).png'),
              label: 'About Us',
            ),
          ]),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => const HomeScreen(),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => const ListScreen(),
            );
          case 2:
          default:
            return CupertinoTabView(
              builder: (context) => const AboutUsScreen(),
            );
        }
      },
    );
  }
}
