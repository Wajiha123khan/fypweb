import 'package:bottom_bar/bottom_bar.dart';
import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/views/student/Home/student_home_screen.dart';
import 'package:classchronicalapp/views/student/notifications/student_notifications_screen.dart';
import 'package:classchronicalapp/views/student/profile/student_profile_screen.dart';
import 'package:classchronicalapp/views/student/schedule/student_schedule_screen.dart';
import 'package:flutter/material.dart';

class StudentNavBar extends StatefulWidget {
  const StudentNavBar({super.key});

  @override
  State<StudentNavBar> createState() => _StudentNavBarState();
}

class _StudentNavBarState extends State<StudentNavBar> {
  var _selectedTab = 0;

  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          StudentHomeScreen(),
          StudentScheduleScreen(),
          StudentsNotificationScreen(),
          StudentProfileScreen()
        ],
        onPageChanged: (index) {
          setState(() => _selectedTab = index);
        },
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(border: Border.all(color: themegreycolor)),
        child: BottomBar(
          backgroundColor: themewhitecolor,
          selectedIndex: _selectedTab,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _selectedTab = index);
          },
          items: const <BottomBarItem>[
            BottomBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Palette.themecolor,
              activeTitleColor: themewhitecolor,
              activeIconColor: themewhitecolor,
              backgroundColorOpacity: 0.9,
            ),
            BottomBarItem(
              icon: Icon(
                Icons.schedule_sharp,
              ),
              title: Text('Schedule'),
              activeColor: Palette.themecolor,
              activeTitleColor: themewhitecolor,
              activeIconColor: themewhitecolor,
              backgroundColorOpacity: 0.9,
            ),
            BottomBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              title: Text('Notifications'),
              activeColor: Palette.themecolor,
              activeTitleColor: themewhitecolor,
              activeIconColor: themewhitecolor,
              backgroundColorOpacity: 0.9,
            ),
            BottomBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              activeColor: Palette.themecolor,
              activeTitleColor: themewhitecolor,
              activeIconColor: themewhitecolor,
              backgroundColorOpacity: 0.9,
            ),
          ],
        ),
      ),
    );
  }
}
