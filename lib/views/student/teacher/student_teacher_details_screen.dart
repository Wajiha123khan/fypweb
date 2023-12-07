import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:classchronicalapp/color.dart';

class StudentTeacherDetailScreen extends StatefulWidget {
  String teachImg;
  String teacherName;
  StudentTeacherDetailScreen(
      {Key? key, required this.teachImg, required this.teacherName})
      : super(key: key);

  @override
  State<StudentTeacherDetailScreen> createState() =>
      _StudentTeacherDetailScreenState();
}

class _StudentTeacherDetailScreenState
    extends State<StudentTeacherDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.themecolor,
          elevation: 5,
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
          title: const Text(
            "Teacher Detail's",
            style: TextStyle(color: themewhitecolor),
          ),
        ),
        backgroundColor: Palette.themeColor2,
        bottomNavigationBar: CustomSimpleRoundedButton(
          onTap: () {},
          height: size.height / 100 * 7,
          width: size.width,
          buttoncolor: Palette.themecolor,
          borderRadius: const BorderRadius.all(
            Radius.circular(0),
          ),
          child: const Text(
            "Chat With Teacher",
            style: TextStyle(color: themewhitecolor),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: size.height / 100 * 5,
            ),
            GestureDetector(
              onTap: () {
                RouteNavigator.route(
                    context,
                    Hero(
                      tag: "teacher",
                      child: Image.network(
                        widget.teachImg,
                      ),
                    ));
              },
              child: CircleAvatar(
                radius: 73,
                backgroundColor: themewhitecolor,
                child: Hero(
                  tag: "teacher",
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      widget.teachImg,
                    ),
                    backgroundColor: themegreytextcolor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 100 * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: themewhitecolor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 20,
                    color: Palette.themecolor,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Text(
                    widget.teacherName,
                    style: const TextStyle(
                      color: themewhitecolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 100 * 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: themewhitecolor,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "teacherDetailData.email",
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 100 * 3,
            ),
            Expanded(
              child: Container(
                width: size.width,
                height: size.height / 100 * 65,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: const BoxDecoration(
                  color: themewhitecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height / 100 * 2,
                    ),
                    //about me container
                    Container(
                      width: size.width,
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: const BoxDecoration(
                        color: Palette.themeColor2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: themewhitecolor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.drive_file_rename_outline_outlined,
                              color: Palette.themecolor,
                            ),
                          ),
                          SizedBox(
                            width: size.width / 100 * 2.5,
                          ),
                          const Flexible(
                            child: Text(
                              "About Me",
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                        color: themewhitecolor,
                        boxShadow: [
                          BoxShadow(
                            color: themeblackcolor.withOpacity(0.3),
                            blurRadius: 10.0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height / 100 * 1,
                          ),
                          // details
                          const Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                            style: TextStyle(
                              color: themegreytextcolor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: size.height / 100 * 2,
                    ),

                    //Qualifications container
                    Container(
                      width: size.width,
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: const BoxDecoration(
                        color: Palette.themeColor2,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: themewhitecolor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.school_outlined,
                              color: Palette.themecolor,
                            ),
                          ),
                          SizedBox(
                            width: size.width / 100 * 2.5,
                          ),
                          const Flexible(
                            child: Text(
                              "Qualifications",
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                        color: themewhitecolor,
                        boxShadow: [
                          BoxShadow(
                            color: themeblackcolor.withOpacity(0.3),
                            blurRadius: 10.0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height / 100 * 1,
                          ),
                          // details
                          const Text(
                            "teacherDetailData.qualification",
                            style: TextStyle(
                              color: themegreytextcolor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
