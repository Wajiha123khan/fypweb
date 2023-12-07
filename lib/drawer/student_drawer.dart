import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/navigation/student_nav_bar.dart';
import 'package:classchronicalapp/routes.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({Key? key}) : super(key: key);

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  @override
  void initState() {
    userDetailsFunc();

    super.initState();
  }

  userDetailsFunc() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? login_Type = prefs.getString('type');
    final String? first_Name = prefs.getString('first_name');
    final String? last_Name = prefs.getString('last_name');
    final String? email_ = prefs.getString('email');

    setState(() {
      type = login_Type.toString();
      firstName = first_Name.toString();
      lastName = last_Name.toString();
      emailName = email_.toString();
    });
    log("login_Type: $login_Type");
    log("default_type: $type");
  }

  String type = '';
  String firstName = '';
  String lastName = '';
  String emailName = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //top backarrow - darkmode - horizontal icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        Container(
          height: 80,
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: themegreycolor,
          ),
          child: Image.asset(
            height: 80,
            "assets/images/png/logo-horizontal.png",
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(
          height: 12,
        ),
        //home
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: ListTile(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              RouteNavigator.route(context, const StudentNavBar());
            },
            leading: const Icon(
              Icons.home,
              color: Palette.themecolor,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.school_outlined,
              color: Palette.themecolor,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subjects",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.quiz_outlined,
              color: Palette.themecolor,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Teachers",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        //Exams
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.book_rounded,
              color: Palette.themecolor,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Exams",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(
                width: 10,
                child: Divider(),
              ),
              Text(
                "APP CONTROLS",
                style: TextStyle(
                  color: greycolor,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 50 * 4,
                child: Divider(),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.info_outline,
              color: Palette.themecolor,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "About Us",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.phone,
              color: Palette.themecolor,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact Us",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "App Version 1.0.0",
              style: TextStyle(
                color: greycolor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding user_profile_container_widget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 20,
                          color: Palette.themecolor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$firstName, $lastName",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right_outlined,
                          size: 16,
                          color: Color.fromRGBO(
                            104,
                            118,
                            132,
                            0.4,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        // FlutterClipboard.copy('hello flutter friends')
                        //     .then((value) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       duration: Duration(
                        //         milliseconds: 300,
                        //       ),
                        //       content: Text("Email Copied!"),
                        //     ),
                        //   );
                        // });
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.email,
                            size: 20,
                            color: Palette.themecolor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Email: ${emailName.toString()}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(169, 171, 172, 1),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.content_copy_outlined,
                            size: 16,
                            color: Color.fromRGBO(169, 171, 172, 1),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }
}
