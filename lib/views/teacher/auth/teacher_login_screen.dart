import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/provider/teacher_pro.dart';
import 'package:classchronicalapp/widgets/custom_button.dart';
import 'package:classchronicalapp/widgets/custom_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  bool visiblePass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    height: 260,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/jpg/background.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: themewhitecolor,
                              shape: BoxShape.circle,
                            ),
                            child: CustomIconButton(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 20,
                                color: Palette.themecolor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            "Sign in to your\nTeacher Account",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Sign in to your Teacher Account",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailC,
                            decoration: InputDecoration(
                              fillColor: themelightgreycolor,
                              filled: true,
                              hintText: "Enter Email",
                              labelText: "Email",
                              hintStyle: const TextStyle(
                                fontSize: 12,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding:
                                  const EdgeInsets.only(left: 12, top: 8),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: passwordC,
                            obscureText: visiblePass,
                            decoration: InputDecoration(
                              fillColor: themelightgreycolor,
                              filled: true,
                              hintText: "Enter Password",
                              labelText: "Password",
                              hintStyle: const TextStyle(
                                fontSize: 12,
                              ),
                              suffixIcon: CustomIconButton(
                                onTap: () {
                                  if (visiblePass == true) {
                                    setState(() {
                                      visiblePass = false;
                                    });
                                  } else if (visiblePass == false) {
                                    setState(() {
                                      visiblePass = true;
                                    });
                                  }
                                },
                                child: Icon(
                                  visiblePass == false
                                      ? CupertinoIcons.lock
                                      : CupertinoIcons.lock_fill,
                                  color: Palette.themecolor,
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding:
                                  const EdgeInsets.only(left: 12, top: 8),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                final teacherProvider = Provider.of<TeacherPro>(
                                    context,
                                    listen: false);
                                teacherProvider.teacherLoginFunc(
                                    emailC.text, passwordC.text, context);
                              }
                            },
                            height: 55,
                            width: double.infinity,
                            buttoncolor: Palette.themecolor,
                            borderRadius: BorderRadius.circular(12),
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: themewhitecolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
