import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/views/student/auth/student_login_screen.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool hidebuttonontextfield = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
        title: const Text("Forgot Your Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 20,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/png/result.png",
                  height: 260,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter your registered email below to receive password reset instruction",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "Enter your Email",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onTap: () {
                          setState(
                            () {
                              hidebuttonontextfield = true;
                            },
                          );
                        },
                        onFieldSubmitted: (check) {
                          setState(
                            () {
                              hidebuttonontextfield = false;
                            },
                          );
                        },
                        decoration: InputDecoration(
                          hintText: "Email here",
                          hintStyle: const TextStyle(fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: themegreycolor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: themeredcolor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            hidebuttonontextfield == true
                ? Container()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomSimpleRoundedButton(
                      onTap: () {
                        RouteNavigator.replacementroute(
                          context,
                          const StudentLoginScreen(),
                        );
                      },
                      height: 50,
                      width: size.width / 100 * 80,
                      buttoncolor: Palette.themecolor,
                      borderRadius: BorderRadius.circular(12),
                      child: const Text(
                        "Send password reset email",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
