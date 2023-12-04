import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/views/student/profile/privacy_policy_screen.dart';
import 'package:flutter/material.dart';

import 'change_password_screen.dart';
import 'edit_profile_screen.dart';
import 'faq_screen.dart';
import 'help_center_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            width: size.width,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Palette.themecolor,
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(20),
              //   bottomRight: Radius.circular(20),
              // ),
            ),
            child: SafeArea(
              child: Column(
                children: [
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
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundColor: themewhitecolor,
                      child: Hero(
                        tag: "profile",
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: themewhitecolor,
                          backgroundImage:
                              AssetImage("assets/images/jpg/avatar.jpeg"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Saba Khan",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: themewhitecolor,
                        child: Icon(
                          Icons.male,
                          color: Palette.themecolor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: themewhitecolor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "sabakhan@gmail.com",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Column(
              children: List.generate(
                profilemodel.length,
                (index) => ListTile(
                  onTap: () {
                    if (index == 0) {
                      RouteNavigator.route(
                        context,
                        const EditProfileScreen(),
                      );
                    } else if (index == 1) {
                      RouteNavigator.route(
                        context,
                        const ChangePasswordScreen(),
                      );
                    } else if (index == 2) {
                      RouteNavigator.route(
                        context,
                        const PrivacyPolicyScreen(),
                      );
                    } else if (index == 3) {
                      RouteNavigator.route(
                        context,
                        const FaqScreen(),
                      );
                    } else if (index == 4) {
                      RouteNavigator.route(
                        context,
                        const HelpCenterScreen(),
                      );
                    } else if (index == 5) {
                      // RouteNavigator.pushandremoveroute(
                      //   context,
                      //   const LoginScreen(),
                      // );
                    }
                  },
                  minVerticalPadding: 25,
                  leading: CircleAvatar(
                    backgroundColor: Palette.themecolor.withOpacity(0.2),
                    child: profilemodel[index].icon,
                  ),
                  title: Text(
                    profilemodel[index].title,
                    style: const TextStyle(
                      color: themeblackcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileModel {
  final Icon icon;
  final String title;
  ProfileModel({required this.icon, required this.title});
}

List<ProfileModel> profilemodel = [
  ProfileModel(
    icon: const Icon(
      Icons.person_outline,
      color: Palette.themecolor,
    ),
    title: "Edit Profile",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.lock_outline,
      color: Palette.themecolor,
    ),
    title: "Change Password",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.privacy_tip_outlined,
      color: Palette.themecolor,
    ),
    title: "Privacy policy",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.format_quote,
      color: Palette.themecolor,
    ),
    title: "FAQ's",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.help_outline,
      color: Palette.themecolor,
    ),
    title: "Help Center",
  ),
  ProfileModel(
    icon: const Icon(
      Icons.logout,
      color: Palette.themecolor,
    ),
    title: "Logout",
  ),
];