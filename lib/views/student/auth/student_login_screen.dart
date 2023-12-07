import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/navigation/student_nav_bar.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/views/student/auth/forgot_password/forgot_password_screen.dart';
import 'package:classchronicalapp/widgets/custom_button.dart';
import 'package:classchronicalapp/widgets/custom_icon_button.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:classchronicalapp/widgets/custom_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'register_screen.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  bool visiblePass = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                          Text(
                            "Sign in to your\nAccount",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Sign in to your Account",
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
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailC,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
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
                              contentPadding: const EdgeInsets.only(
                                left: 12,
                                top: 8,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: passwordC,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
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
                              contentPadding: const EdgeInsets.only(
                                left: 12,
                                top: 8,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is empty.";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: CustomTextButton(
                              buttonText: "Forgot Password?",
                              onTap: () {
                                RouteNavigator.route(
                                  context,
                                  const ForgotPasswordScreen(),
                                );
                              },
                              textstyle: const TextStyle(
                                color: Palette.themecolor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final authProvider = Provider.of<AuthPro>(
                                    context,
                                    listen: false);

                                authProvider.studentLoginFunc(
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                    color: themeblackcolor,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => RouteNavigator.route(
                              context,
                              const RegisterScreen(),
                            ),
                      text: "Register",
                      style: const TextStyle(
                        color: Palette.themecolor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
