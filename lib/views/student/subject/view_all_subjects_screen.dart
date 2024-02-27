import 'package:classchronicalapp/model/student/subject_model.dart';
import 'package:classchronicalapp/model/teacher/teacher_assign_model.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/utils/reusable_methods.dart';
import 'package:classchronicalapp/views/student/subject/student_subject_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:classchronicalapp/color.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StudentViewAllSubjectsScreen extends StatefulWidget {
  int type;
  String teacherId;
  StudentViewAllSubjectsScreen(
      {Key? key, required this.type, required this.teacherId})
      : super(key: key);

  @override
  State<StudentViewAllSubjectsScreen> createState() =>
      _StudentViewAllSubjectsScreenState();
}

class _StudentViewAllSubjectsScreenState
    extends State<StudentViewAllSubjectsScreen> {
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
        title: widget.type == 0
            ? const Text("Teacher's")
            : const Text("Subject's"),
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
              Text(
                widget.type == 0 ? "Your Teachers" : "Your Subjects",
                style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              widget.type == 0
                  ? StreamBuilder<List<SubjectModel>>(
                      stream: filterStudentSubjects(authModel.getSemesterId),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
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
                                    var subjectData = modelData[index];
                                    return InkWell(
                                      onTap: () {
                                        RouteNavigator.route(
                                            context,
                                            StudentSubjectDetailScreen(
                                              subjectId: subjectData.subject_id,
                                            ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  subjectData.subject_image,
                                                ),
                                                opacity: 0.8,
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: themegreycolor
                                                    .withOpacity(0.5),
                                                blurRadius: 10.0,
                                                offset: const Offset(0, 5),
                                              ),
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Spacer(),
                                            CircleAvatar(
                                              radius: 63,
                                              backgroundColor: themewhitecolor,
                                              child: CircleAvatar(
                                                radius: 60,
                                                backgroundImage: NetworkImage(
                                                  subjectData.subject_image,
                                                ),
                                                backgroundColor:
                                                    themegreytextcolor,
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                                width: size.width,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Palette.themecolor,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                child: Text(
                                                  subjectData.title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: themewhitecolor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                        } else {
                          return Container();
                        }
                      })
                  : StreamBuilder<List<TeacherAssignModel>>(
                      stream: filter_assigned_subject(widget.teacherId),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                              'Something went wrong! ${snapshot.error}');
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
                                    var subjectData = modelData[index];
                                    return InkWell(
                                      onTap: () {
                                        RouteNavigator.route(
                                            context,
                                            StudentSubjectDetailScreen(
                                              subjectId: subjectData.subject_id,
                                            ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&w=1600",
                                                ),
                                                opacity: 0.8,
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: themegreycolor
                                                    .withOpacity(0.5),
                                                blurRadius: 10.0,
                                                offset: const Offset(0, 5),
                                              ),
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Spacer(),
                                            CircleAvatar(
                                              radius: 63,
                                              backgroundColor: themewhitecolor,
                                              child: FutureBuilder<String>(
                                                  future: ReusableMethods()
                                                      .subjectImageGet(
                                                          subjectData
                                                              .subject_id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      String Datara =
                                                          snapshot.data!;

                                                      return CircleAvatar(
                                                        radius: 60,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          Datara,
                                                        ),
                                                        backgroundColor:
                                                            themegreytextcolor,
                                                      );
                                                    } else {
                                                      return CircleAvatar(
                                                        radius: 60,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&w=1600",
                                                        ),
                                                        backgroundColor:
                                                            themegreytextcolor,
                                                      );
                                                    }
                                                  }),
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: size.width,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                ),
                                                color: Palette.themecolor,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                              child: FutureBuilder<String>(
                                                  future: ReusableMethods()
                                                      .subjectNameGet(
                                                          subjectData
                                                              .subject_id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      String Datara =
                                                          snapshot.data!;

                                                      return Text(
                                                        Datara,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color:
                                                              themewhitecolor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      );
                                                    } else {
                                                      return const Text("");
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

  //student all subject
  Stream<List<SubjectModel>> filterStudentSubjects(String semesterId) =>
      FirebaseFirestore.instance
          .collection('subject')
          .where('semester_id', isEqualTo: semesterId.toString())
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) => SubjectModel.fromJson(document.data()))
              .toList());

  Stream<List<TeacherAssignModel>> filter_assigned_subject(String teacher_id) =>
      FirebaseFirestore.instance
          .collection('teacher_assign')
          .where('teacher_id', isEqualTo: teacher_id)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) => TeacherAssignModel.fromJson(document.data()))
              .toList());
}
