
import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentWaitingScreen extends StatefulWidget {
  final String message;
  const StudentWaitingScreen({Key? key, required this.message})
      : super(key: key);

  @override
  State<StudentWaitingScreen> createState() => _StudentWaitingScreenState();
}

class _StudentWaitingScreenState extends State<StudentWaitingScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themewhitecolor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                FirebaseAuth.instance.signOut();
                RouteNavigator.replacementroute(context, SplashScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: themewhitecolor,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout_outlined,
                      color: Palette.themecolor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Palette.themecolor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/png/wait_for_approval.png",
              height: height / 100 * 50,
            ),
          ),
        ],
      ),
    );
  }
}
