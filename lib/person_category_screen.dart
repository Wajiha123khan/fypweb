import 'package:classchronicalapp/views/student/auth/student_login_screen.dart';
import 'package:classchronicalapp/views/teacher/auth/teacher_login_screen.dart';
import 'package:classchronicalapp/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/routes.dart';

class PersonCategoryScreen extends StatefulWidget {
  const PersonCategoryScreen({Key? key}) : super(key: key);

  @override
  State<PersonCategoryScreen> createState() => _PersonCategoryScreenState();
}

class _PersonCategoryScreenState extends State<PersonCategoryScreen> {
  int? selectedtype = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/jpg/background.jpg",
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height / 100 * 2,
              ),
              Image.asset(
                "assets/images/png/logo-horizontal.png",
                width: 350,
                fit: BoxFit.cover,
              ),
              const Spacer(),

              const Center(
                child: Text(
                  "Choose Category",
                  style: TextStyle(
                      fontSize: 24,
                      color: themewhitecolor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height / 100 * 2,
              ),
              // const Spacer(),
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: personcategorymodel.length,
                itemBuilder: (context, index) {
                  return selectedtype == index
                      ? Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: themewhitecolor),
                            boxShadow: [
                              BoxShadow(
                                color: themegreycolor.withOpacity(0.3),
                                blurRadius: 10.0,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Palette.themecolor,
                                radius: 12,
                                child: Icon(
                                  Icons.check,
                                  size: 15,
                                  color: themewhitecolor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: themewhitecolor,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: themegreytextcolor,
                                  child: SvgPicture.asset(
                                    personcategorymodel[index].image,
                                    width: 40,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  personcategorymodel[index]
                                      .title
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      color: themewhitecolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            setState(() {
                              selectedtype = index;
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              // color: Palette.themecolor,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: themegreycolor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: themegreycolor,
                                  child: SvgPicture.asset(
                                    personcategorymodel[index].image,
                                    width: 40,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  personcategorymodel[index]
                                      .title
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: themewhitecolor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),

              const Spacer(),
              CustomButton(
                onTap: () {
                  if (selectedtype == 0) {
                    RouteNavigator.route(context, const StudentLoginScreen());
                  } else {
                    RouteNavigator.route(context, const TeacherLoginScreen());
                  }
                  debugPrint(selectedtype.toString());
                },
                height: 55,
                width: double.infinity,
                buttoncolor: Palette.themecolor,
                borderRadius: BorderRadius.circular(12),
                child: const Text(
                  "DONE",
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
    );
  }
}

class PersonCategoryModel {
  final String title;
  final String image;
  PersonCategoryModel({required this.title, required this.image});
}

List<PersonCategoryModel> personcategorymodel = [
  PersonCategoryModel(
    title: "Student",
    image: "assets/student.svg",
  ),
  PersonCategoryModel(
    title: "Teacher",
    image: "assets/teacher.svg",
  )
];
