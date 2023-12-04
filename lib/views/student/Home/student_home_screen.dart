import 'dart:developer';

import 'package:classchronicalapp/model/dummy_models.dart';
import 'package:classchronicalapp/model/student/student_model.dart';
import 'package:classchronicalapp/model/teacher/teacher_model.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/splash/splash_screen.dart';
import 'package:classchronicalapp/views/student/teacher/student_teacher_details_screen.dart';
import 'package:classchronicalapp/views/student/teacher/view_all_teachers_screen.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/drawer/student_drawer.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  List<DateTime?> _value = [
    DateTime.now(),
  ];

  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    log("Current User: ${FirebaseAuth.instance.currentUser!.uid}");
    final size = MediaQuery.of(context).size;
    final authModel = Provider.of<AuthPro>(context);
    return Scaffold(
      backgroundColor: themeprimarycolor,
      drawer: SafeArea(
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                StudentDrawer(),
              ],
            ),
          ),
        ),
      ),
      body: ColorfulSafeArea(
        color: Palette.themecolor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Class Chronical App"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        FirebaseAuth.instance.signOut();
                        RouteNavigator.pushandremoveroute(
                            context, const SplashScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: themewhitecolor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.logout,
                          color: Palette.themecolor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(220),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hi, Saba Khan',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'Let’s start learning',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    RouteNavigator.route(
                                        context,
                                        Hero(
                                          tag: "profile",
                                          child: Image.asset(
                                            "assets/images/jpg/avatar.jpeg",
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: themewhitecolor
                                                .withOpacity(0.8),
                                            width: 2)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Hero(
                                        tag: "profile",
                                        child: Image.asset(
                                          "assets/images/jpg/avatar.jpeg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                            //progress container
                            Container(
                              width: size.width,
                              height: 70,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Palette.themeColor2,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Degree : ",
                                        style: TextStyle(
                                            color: themewhitecolor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "Computer Science",
                                        style: TextStyle(
                                            color: themewhitecolor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  color: Palette.themecolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
              ),
            ),
            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            //today class timetable
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Today"),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Monday, 22 march 2022",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          lastDayOfMonth.day,
                          (index) {
                            final currentDate =
                                lastDayOfMonth.add(Duration(days: index + 1));
                            final dayName =
                                DateFormat('EEE').format(currentDate);
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 16.0,
                              ),
                              child: InkWell(
                                onTap: () => setState(
                                  () {
                                    selectedIndex = index;
                                  },
                                ),
                                child: Container(
                                  width: 80,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Palette.themecolor
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: selectedIndex == index
                                          ? Colors.transparent
                                          : themegreytextcolor,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dayName.toString(),
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: selectedIndex == index
                                              ? themewhitecolor
                                              : themeblackcolor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                          fontSize: 28.0,
                                          color: selectedIndex == index
                                              ? themewhitecolor
                                              : themeblackcolor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: selectedIndex == index
                                              ? themewhitecolor
                                              : Palette.themecolor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Timetable Schedule",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: 5,
                              decoration: BoxDecoration(
                                color: Palette.themecolor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              "23\nNOV",
                              style: TextStyle(
                                color: Palette.themecolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            const CircleAvatar(
                              radius: 15,
                              backgroundColor: Palette.themecolor,
                              backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&w=1600"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Linear Algebra",
                                  style: TextStyle(
                                    color: themegreytextcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "1:00 PM - 2:00 PM",
                                  style: TextStyle(
                                    color: themegreytextcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CustomSimpleRoundedButton(
                              onTap: () {},
                              height: 40,
                              width: size.width / 100 * 22,
                              buttoncolor: Palette.themecolor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30),
                              child: const Text(
                                "View Details",
                                style: TextStyle(
                                  color: Palette.themecolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, separator) {
                        return Divider(
                          thickness: 3,
                        );
                        // return Image.asset(
                        //   "assets/images/png/wave-divider-big.png",
                        //   height: 50,
                        // );
                      },
                    ),
                  ],
                ),
              ),
            ),
            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),

            //subject -- view all
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Subject",
                      style: TextStyle(
                        color: themeblackcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: themeblackcolor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //all subject
            SliverToBoxAdapter(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                    children: List.generate(subjectModelList.length, (index) {
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Container(
                        height: 130,
                        width: 200,
                        decoration: BoxDecoration(
                            color: themewhitecolor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: themegreycolor.withOpacity(0.5),
                                blurRadius: 10.0,
                                offset: const Offset(0, 5),
                              ),
                            ]),
                        child: Column(
                          children: [
                            SizedBox(
                                height: 100,
                                width: size.width,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    subjectModelList[index].userImage,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Text(
                                subjectModelList[index].subjectName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: themeblackcolor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
              ),
            )),

            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            //Your subject teachers -- view all
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Your Teachers",
                      style: TextStyle(
                        color: themeblackcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        RouteNavigator.route(
                            context, StudentViewAllTeachersScreen());
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: themeblackcolor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                    children:
                        List.generate(tempTeacherModelList.length, (index) {
                  return InkWell(
                    onTap: () {
                      RouteNavigator.route(
                          context,
                          StudentTeacherDetailScreen(
                            teachImg: tempTeacherModelList[index].userImage,
                            teacherName:
                                tempTeacherModelList[index].teacherName,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                      ),
                      child: Container(
                        height: size.height / 100 * 23,
                        width: size.width / 100 * 33,
                        decoration: BoxDecoration(
                            color: themewhitecolor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: themegreycolor.withOpacity(0.5),
                                blurRadius: 10.0,
                                offset: const Offset(0, 5),
                              ),
                            ]),
                        child: Column(
                          children: [
                            SizedBox(
                                height: size.height / 100 * 20,
                                width: size.width,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    tempTeacherModelList[index].userImage,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              tempTeacherModelList[index].teacherName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: themeblackcolor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
              ),
            )),

            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<StudentModel> myProfileFilter(String currentUserUid) {
    return FirebaseFirestore.instance
        .collection('student_auth')
        .doc(currentUserUid)
        .snapshots()
        .map((snapshot) => StudentModel.fromSnap(snapshot));
  }

  Stream<TeacherModel> filterTEacher(String currentUserUid) {
    return FirebaseFirestore.instance
        .collection('teacher_auth')
        .doc(currentUserUid)
        .snapshots()
        .map((snapshot) => TeacherModel.fromSnap(snapshot));
  }
}
