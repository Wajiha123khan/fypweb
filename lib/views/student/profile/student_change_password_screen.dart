import 'dart:developer';

import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/widgets/custom_icon_button.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentChangePasswordScreen extends StatefulWidget {
  const StudentChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<StudentChangePasswordScreen> createState() =>
      _StudentChangePasswordScreenState();
}

class _StudentChangePasswordScreenState
    extends State<StudentChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordC = TextEditingController();
  final TextEditingController newPasswordC = TextEditingController();
  final TextEditingController cPasswordC = TextEditingController();

  bool visibleOldPass = true;
  bool visiblePass = true;
  bool visibleRepeatPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: themegreycolor,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: Palette.themecolor,
              ),
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: const Text("Change Password"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomSimpleRoundedButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              final PostProvider = Provider.of<AuthPro>(context, listen: false);
              log("User Id: ${FirebaseAuth.instance.currentUser!.uid}");
              PostProvider.studentPasswordUpdateFunc(
                  FirebaseAuth.instance.currentUser!.uid,
                  oldPasswordC.text,
                  newPasswordC.text,
                  context);
            }
          },
          buttoncolor: Palette.themecolor,
          height: kMinInteractiveDimension,
          width: MediaQuery.of(context).size.width * 0.85,
          borderRadius: BorderRadius.circular(12),
          child: const Text(
            "Update",
            style: TextStyle(
              color: themewhitecolor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/png/chat.png",
                  height: 250,
                ),
                const SizedBox(
                  height: 60,
                ),
                //old password
                TextFormField(
                  controller: oldPasswordC,
                  keyboardType: const TextInputType.numberWithOptions(),
                  textInputAction: TextInputAction.next,
                  obscureText: visibleOldPass,
                  decoration: InputDecoration(
                    fillColor: themelightgreycolor,
                    filled: true,
                    hintText: "Old Password",
                    labelText: "Password",
                    hintStyle: const TextStyle(
                      fontSize: 12,
                    ),
                    suffixIcon: CustomIconButton(
                      onTap: () {
                        if (visibleOldPass == true) {
                          setState(() {
                            visibleOldPass = false;
                          });
                        } else if (visibleOldPass == false) {
                          setState(() {
                            visibleOldPass = true;
                          });
                        }
                      },
                      child: Icon(
                        visibleOldPass == false
                            ? CupertinoIcons.lock
                            : CupertinoIcons.lock_fill,
                        color: Palette.themecolor,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      return "Old Password is empty.";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: newPasswordC,
                  keyboardType: const TextInputType.numberWithOptions(),
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
                    floatingLabelBehavior: FloatingLabelBehavior.always,
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
                  height: 25,
                ),
                TextFormField(
                  controller: cPasswordC,
                  obscureText: visibleRepeatPass,
                  decoration: InputDecoration(
                    fillColor: themelightgreycolor,
                    filled: true,
                    hintText: "Enter Repeat Password",
                    labelText: "Repeat Password",
                    hintStyle: const TextStyle(
                      fontSize: 12,
                    ),
                    suffixIcon: CustomIconButton(
                      onTap: () {
                        if (visibleRepeatPass == true) {
                          setState(() {
                            visibleRepeatPass = false;
                          });
                        } else if (visibleRepeatPass == false) {
                          setState(() {
                            visibleRepeatPass = true;
                          });
                        }
                      },
                      child: Icon(
                        visibleRepeatPass == false
                            ? CupertinoIcons.lock
                            : CupertinoIcons.lock_fill,
                        color: Palette.themecolor,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
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
                      return "Confirm Password is empty.";
                    } else if (value != newPasswordC.text) {
                      return "Confirm Password doesn't match.";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
