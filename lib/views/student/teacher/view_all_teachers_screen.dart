import 'package:classchronicalapp/model/teacher/teacher_assign_model.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/utils/reusable_methods.dart';
import 'package:classchronicalapp/views/student/teacher/student_teacher_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:classchronicalapp/color.dart';
import 'package:provider/provider.dart';

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
    final authModel = Provider.of<AuthPro>(context);

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
              StreamBuilder<List<TeacherAssignModel>>(
                  stream: filter_assigned_teacher(authModel.getSemesterId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final modelData = snapshot.data!;
                      return modelData.isEmpty
                          ? Expanded(
                              child: Center(
                                  child: Image.asset(
                                "assets/images/png/no_teacher.png",
                                // height: 100,
                              )),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(12.0),
                              primary: false,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 220,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 20,
                                crossAxisCount: 2,
                              ),
                              itemCount: modelData.length,
                              itemBuilder: (context, index) {
                                var teacherData = modelData[index];
                                return InkWell(
                                  onTap: () {
                                    RouteNavigator.route(
                                        context,
                                        StudentTeacherDetailScreen(
                                          teacherId: teacherData.teacher_id,
                                        ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                "https://t4.ftcdn.net/jpg/04/61/47/03/360_F_461470323_6TMQSkCCs9XQoTtyer8VCsFypxwRiDGU.jpg"),
                                            opacity: 0.8,
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                themegreycolor.withOpacity(0.5),
                                            blurRadius: 10.0,
                                            offset: const Offset(0, 5),
                                          ),
                                        ]),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Spacer(),
                                        FutureBuilder<String>(
                                            future: ReusableMethods()
                                                .teacherImageGet(teacherData
                                                    .teacher_id
                                                    .toString()),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                String Datara = snapshot.data!;

                                                return CircleAvatar(
                                                  radius: 63,
                                                  backgroundColor:
                                                      themewhitecolor,
                                                  child: CircleAvatar(
                                                    radius: 60,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      Datara,
                                                    ),
                                                    backgroundColor:
                                                        themegreytextcolor,
                                                  ),
                                                );
                                              } else {
                                                return Image.network(
                                                    "https://images.unsplash.com/photo-1584591085084-239509bc9743?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=872&q=80",
                                                    fit: BoxFit.cover);
                                              }
                                            }),
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
                                          child: FutureBuilder<String>(
                                              future: ReusableMethods()
                                                  .teacherNameGet(teacherData
                                                      .teacher_id
                                                      .toString()),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  String Datara =
                                                      snapshot.data!;

                                                  return Text(
                                                    Datara,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: themewhitecolor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  );
                                                } else {
                                                  return const Text(
                                                    "",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: themewhitecolor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  );
                                                }
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  //teacher assigned teacher
  Stream<List<TeacherAssignModel>> filter_assigned_teacher(
          String semester_id) =>
      FirebaseFirestore.instance
          .collection('teacher_assign')
          .where('semester_id', isEqualTo: semester_id)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) => TeacherAssignModel.fromJson(document.data()))
              .toList());
}
