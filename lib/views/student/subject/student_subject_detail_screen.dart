import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/model/student/subject_model.dart';
import 'package:classchronicalapp/model/teacher/teacher_assign_model.dart';
import 'package:classchronicalapp/utils/time_stamp.dart';
import 'package:classchronicalapp/utils/reusable_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StudentSubjectDetailScreen extends StatefulWidget {
  String subjectId;
  StudentSubjectDetailScreen({Key? key, required this.subjectId})
      : super(key: key);

  @override
  State<StudentSubjectDetailScreen> createState() =>
      _StudentSubjectDetailScreenState();
}

class _StudentSubjectDetailScreenState
    extends State<StudentSubjectDetailScreen> {
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
                color: themewhitecolor,
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
        title: const Text("Subject Details"),
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
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<SubjectModel>(
                  stream: filterSubjectsDetails(widget.subjectId),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final subjectDetailData = snapshot.data!;
                      return subjectDetailData.title.isEmpty
                          ? Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/png/referral.png",
                                      height: 100,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "No Referal Found",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  width: size.width,
                                  padding: const EdgeInsetsDirectional.all(10),
                                  decoration: const BoxDecoration(
                                    color: Palette.themecolor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.subject_outlined,
                                        color: themewhitecolor,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Flexible(
                                        child: Text(
                                          subjectDetailData.title.toUpperCase(),
                                          style: const TextStyle(
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
                                  decoration: BoxDecoration(
                                    // color: themeblackcolor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: themegreycolor.withOpacity(0.5),
                                        blurRadius: 10.0,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: size.width,
                                        height: size.height / 100 * 25,
                                        decoration: BoxDecoration(
                                          color:
                                              themeblackcolor.withOpacity(0.5),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                subjectDetailData
                                                    .subject_image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      //time
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .bottomEnd,
                                              child: Text(
                                                timeAgo(subjectDetailData
                                                    .date_time),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: themewhitecolor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 100 * 2,
                                ),
                                //main course objectives
                                detail_container_widget(
                                  "Course Description",
                                  subjectDetailData.course_description,
                                  size.width,
                                  size.height,
                                ),
                                SizedBox(
                                  height: size.height / 100 * 2,
                                ),
                                detail_container_widget(
                                  "Course Objectives",
                                  subjectDetailData.course_objectives,
                                  size.width,
                                  size.height,
                                ),
                                SizedBox(
                                  height: size.height / 100 * 2,
                                ),
                                detail_container_widget(
                                  "Learning Outcomes",
                                  subjectDetailData.learning_outcomes,
                                  size.width,
                                  size.height,
                                ),
                                SizedBox(
                                  height: size.height / 100 * 2,
                                ),
                                detail_container_widget(
                                  "Text / Reference Books",
                                  subjectDetailData.text_referencebooks,
                                  size.width,
                                  size.height,
                                ),
                                SizedBox(
                                  height: size.height / 100 * 2,
                                ),
                                // //Subject Teacher
                                StreamBuilder<List<TeacherAssignModel>>(
                                    stream:
                                        filterAssignedTeacher(widget.subjectId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text(
                                            'Something went wrong! ${snapshot.error}');
                                      } else if (snapshot.hasData) {
                                        final modelData = snapshot.data!;
                                        return modelData.isEmpty
                                            ? Column(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/png/no_teacher.png",
                                                    // height: 100,
                                                  ),
                                                ],
                                              )
                                            : SingleChildScrollView(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 14,
                                                  ),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: List.generate(
                                                          modelData.length,
                                                          (index) {
                                                        var teachers_data =
                                                            modelData[index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 5,
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              // RouteNavigator.route(
                                                              //     context, student_teacher_screen());
                                                            },
                                                            child: Container(
                                                              width:
                                                                  size.width /
                                                                      100 *
                                                                      35,
                                                              // height: height / 100 * 15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    themewhitecolor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  12.0,
                                                                ),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: themegreycolor
                                                                        .withOpacity(
                                                                      0.5,
                                                                    ),
                                                                    blurRadius:
                                                                        10,
                                                                    offset:
                                                                        const Offset(
                                                                      5,
                                                                      10,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  FutureBuilder<
                                                                          String>(
                                                                      future: ReusableMethods().teacherImageGet(teachers_data
                                                                          .teacher_id
                                                                          .toString()),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          String
                                                                              Datara =
                                                                              snapshot.data!;

                                                                          return SizedBox(
                                                                            width: size.width /
                                                                                100 *
                                                                                35,
                                                                            height: size.height /
                                                                                100 *
                                                                                15,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                                                              child: Image.network(Datara, fit: BoxFit.cover),
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          return SizedBox(
                                                                            width: size.width /
                                                                                100 *
                                                                                35,
                                                                            height: size.height /
                                                                                100 *
                                                                                15,
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                                                              child: Image.network("https://images.unsplash.com/photo-1584591085084-239509bc9743?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=872&q=80", fit: BoxFit.cover),
                                                                            ),
                                                                          );
                                                                        }
                                                                      }),

                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  //name
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          5,
                                                                      vertical:
                                                                          5,
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                            Icons
                                                                                .person,
                                                                            size:
                                                                                20),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        FutureBuilder<
                                                                                String>(
                                                                            future:
                                                                                ReusableMethods().teacherNameGet(teachers_data.teacher_id.toString()),
                                                                            builder: (context, snapshot) {
                                                                              if (snapshot.hasData) {
                                                                                String Datara = snapshot.data!;

                                                                                return Text(
                                                                                  Datara.toUpperCase(),
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: const TextStyle(
                                                                                    color: themeblackcolor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                );
                                                                              } else {
                                                                                return const Text(
                                                                                  "",
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(
                                                                                    color: themeblackcolor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                );
                                                                              }
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  //email
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            5),
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                            Icons
                                                                                .email,
                                                                            size:
                                                                                20),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        FutureBuilder<
                                                                                String>(
                                                                            future:
                                                                                ReusableMethods().teacherEmailGet(teachers_data.teacher_id.toString()),
                                                                            builder: (context, snapshot) {
                                                                              if (snapshot.hasData) {
                                                                                String Datara = snapshot.data!;

                                                                                return Text(
                                                                                  Datara,
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: const TextStyle(
                                                                                    color: themeblackcolor,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                );
                                                                              } else {
                                                                                return const Text(
                                                                                  "",
                                                                                  maxLines: 1,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(
                                                                                    color: themeblackcolor,
                                                                                    fontSize: 14,
                                                                                  ),
                                                                                );
                                                                              }
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  //teacher assigned subject
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            5),
                                                                    child: Row(
                                                                        children: [
                                                                          const Icon(
                                                                              Icons.school_outlined,
                                                                              size: 20),
                                                                          const SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          FutureBuilder<String>(
                                                                              future: ReusableMethods().subjectNameGet(teachers_data.subject_id.toString()),
                                                                              builder: (context, snapshot) {
                                                                                if (snapshot.hasData) {
                                                                                  String Datara = snapshot.data!;

                                                                                  return Flexible(
                                                                                    child: Text(
                                                                                      Datara,
                                                                                      maxLines: 2,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: const TextStyle(
                                                                                        color: themeblackcolor,
                                                                                        fontSize: 14,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                } else {
                                                                                  return const Text("");
                                                                                }
                                                                              }),
                                                                        ]),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                                ),
                                              );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                SizedBox(
                                  height: size.height / 100 * 2,
                                ),
                              ],
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

  Container detail_container_widget(
    String headerName,
    String content,
    double width,
    double height,
  ) {
    return Container(
        width: width,
        padding: const EdgeInsetsDirectional.all(10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: themeblackcolor.withOpacity(0.3),
            blurRadius: 10.0,
            offset: const Offset(0, 3),
          ),
        ], color: themewhitecolor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //top text
            Container(
              padding: const EdgeInsetsDirectional.all(10),
              decoration: BoxDecoration(
                  color: Palette.themecolor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Icon(
                    Icons.subject_outlined,
                    color: themewhitecolor,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      headerName,
                      style: const TextStyle(
                        color: themewhitecolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height / 100 * 1,
            ),
            // details
            Text(
              content,
              style: const TextStyle(
                color: themegreytextcolor,
                fontSize: 16,
              ),
            ),
          ],
        ));
  }

  Stream<SubjectModel> filterSubjectsDetails(String subjectId) {
    return FirebaseFirestore.instance
        .collection('subject')
        .doc(subjectId)
        .snapshots()
        .map((snapshot) => SubjectModel.fromSnap(snapshot));
  }

//teacher assigned teacher
  Stream<List<TeacherAssignModel>> filterAssignedTeacher(String subjectId) =>
      FirebaseFirestore.instance
          .collection('teacher_assign')
          .where('subject_id', isEqualTo: subjectId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) => TeacherAssignModel.fromJson(document.data()))
              .toList());
}
