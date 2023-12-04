import 'package:classchronicalapp/model/dummy_models.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/views/student/teacher/student_teacher_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:classchronicalapp/color.dart';

class StudentViewAllTeachersScreen extends StatefulWidget {
  const StudentViewAllTeachersScreen({Key? key}) : super(key: key);

  @override
  State<StudentViewAllTeachersScreen> createState() =>
      _StudentViewAllTeachersScreenState();
}

class _StudentViewAllTeachersScreenState
    extends State<StudentViewAllTeachersScreen> {
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
        title: const Text("Your Teacher's"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Teachers",
                style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              GridView.builder(
                padding: const EdgeInsets.all(12.0),
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 220,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                ),
                itemCount: tempTeacherModelList.length,
                itemBuilder: (context, index) {
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
                    child: Container(
                      decoration: BoxDecoration(
                          // color: themegreytextcolor,
                          image: DecorationImage(
                              image: NetworkImage(
                                tempTeacherModelList[index].userImage,
                              ),
                              opacity: 0.8,
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: themegreycolor.withOpacity(0.5),
                              blurRadius: 10.0,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          CircleAvatar(
                            radius: 63,
                            backgroundColor: themewhitecolor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                tempTeacherModelList[index].userImage,
                              ),
                              backgroundColor: themegreytextcolor,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: size.width,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              color: Palette.themecolor,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Text(
                              tempTeacherModelList[index].teacherName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
