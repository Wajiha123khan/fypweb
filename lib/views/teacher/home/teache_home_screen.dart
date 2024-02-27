import 'package:classchronicalapp/model/student/timetable_schedule_model.dart';
import 'package:classchronicalapp/model/teacher/teacher_assign_model.dart';
import 'package:classchronicalapp/model/teacher/teacher_model.dart';
import 'package:classchronicalapp/provider/teacher_pro.dart';
import 'package:classchronicalapp/splash/splash_screen.dart';
import 'package:classchronicalapp/utils/reusable_methods.dart';
import 'package:classchronicalapp/views/student/subject/student_subject_detail_screen.dart';
import 'package:classchronicalapp/views/student/subject/view_all_subjects_screen.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/drawer/student_drawer.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({Key? key}) : super(key: key);

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {


  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    final teacherModel = Provider.of<TeacherPro>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themeprimarycolor,
      drawer: SafeArea(
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                StudentDrawer(),
              ],
            ),
          ),
        ),
      ),
      body: ColorfulSafeArea(
        color: Palette.themecolor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Class Chronical App"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.remove('teacher_uid');
                        RouteNavigator.replacementroute(
                          context,
                          const SplashScreen(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: themewhitecolor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.logout,
                          color: Palette.themecolor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(220),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: StreamBuilder<TeacherModel>(
                    stream: filterTeacher(teacherModel.teacher_uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final studentModel = snapshot.data!;

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Hi, ${studentModel.first_name.toUpperCase()} ${studentModel.last_name.toUpperCase()}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Welcome to Teacher Portal',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          RouteNavigator.route(
                                              context,
                                              Hero(
                                                tag: "profile",
                                                child: Image.network(
                                                    studentModel.profile),
                                              ));
                                        },
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: themewhitecolor
                                                      .withOpacity(0.8),
                                                  width: 2)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Hero(
                                              tag: "profile",
                                              child: Image.network(
                                                studentModel.profile,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),
                                  //progress container
                                  Container(
                                    width: size.width,
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: Palette.themeColor2,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Qualification: ",
                                              style: TextStyle(
                                                  color: themewhitecolor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14),
                                            ),
                                            Flexible(
                                              child: Text(
                                                studentModel.qualification,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: themewhitecolor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Colors.grey.shade200));
                      }
                    },
                  ),
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  color: Palette.themecolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
              ),
            ),
            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            //today class timetable
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Today"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateFormat.yMd()
                          .add_jm()
                          .format(Timestamp.now().toDate()),
                      // "Monday, 22 march 2022",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<List<TimetableScheduleModel>>(
                        stream: filterSubjectTimtable(
                          teacherModel.getTeacherUid,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                                'Something went wrong! ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final modelData = snapshot.data!;
                            return modelData.isEmpty
                                ? Center(
                                    child: SizedBox(
                                      height: size.height / 100 * 20,
                                      width: size.width * 100 * 20,
                                      child: Image.asset(
                                        "assets/images/png/no_timetable_available.png",
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Divider(),
                                      const Text(
                                        "Timetable Schedule",
                                        style: TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.separated(
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: modelData.length,
                                        itemBuilder: (context, index) {
                                          var timetableData = modelData[index];
                                          return Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 5,
                                                decoration: BoxDecoration(
                                                  color: Palette.themecolor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                "${modelData[index].scheduleDate.toString().substring(0, 2)}\n${DateFormat.LLL().format(DateTime(int.parse(modelData[index].scheduleDate.toString().substring(6, 10)), int.parse(modelData[index].scheduleDate.toString().substring(3, 5)), int.parse(modelData[index].scheduleDate.toString().substring(0, 2))))} ",
                                                style: const TextStyle(
                                                  color: Palette.themecolor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              FutureBuilder<String>(
                                                  future: ReusableMethods()
                                                      .subjectImageGet(
                                                          timetableData
                                                              .subject_id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      String Datara =
                                                          snapshot.data!;

                                                      return CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                              Palette
                                                                  .themecolor,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  Datara));
                                                    } else {
                                                      return const CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Palette.themecolor,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&w=1600"),
                                                      );
                                                    }
                                                  }),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FutureBuilder<String>(
                                                        future: ReusableMethods()
                                                            .subjectNameGet(
                                                                timetableData
                                                                    .subject_id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            String Datara =
                                                                snapshot.data!;

                                                            return Text(
                                                              Datara,
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    themegreytextcolor,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            );
                                                          } else {
                                                            return const Text(
                                                                "");
                                                          }
                                                        }),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      "${timetableData.startTime} - ${timetableData.endTime}",
                                                      style: const TextStyle(
                                                        color:
                                                            themegreytextcolor,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 3),
                                              CustomSimpleRoundedButton(
                                                onTap: () {
                                                  timetableDetailsDialog(
                                                      context,
                                                      size,
                                                      timetableData);
                                                },
                                                height: size.height / 100 * 5,
                                                width: size.width / 100 * 22,
                                                buttoncolor: Palette.themecolor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: const Text(
                                                  "View Details",
                                                  style: TextStyle(
                                                    color: Palette.themecolor,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, separator) {
                                          return const Divider(
                                            thickness: 3,
                                          );
                                        },
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
            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),

            //subject -- view all
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Assigned Subjects",
                      style: TextStyle(
                        color: themeblackcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        RouteNavigator.route(
                            context,
                            StudentViewAllSubjectsScreen(
                                type: 1,
                                teacherId: teacherModel.getTeacherUid));
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(
                          color: themeblackcolor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //all subject
            SliverToBoxAdapter(
              child: StreamBuilder<List<TeacherAssignModel>>(
                  stream: filter_assigned_subject(teacherModel.getTeacherUid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final subjectData = snapshot.data!;
                      return subjectData.isEmpty
                          ? Expanded(
                              child: Center(
                                  child: Image.asset(
                                "assets/images/png/no_subject.png",
                              )),
                            )
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                child: Row(
                                    children: List.generate(subjectData.length,
                                        (index) {
                                  return InkWell(
                                    onTap: () {
                                      RouteNavigator.route(
                                          context,
                                          StudentSubjectDetailScreen(
                                            subjectId:
                                                subjectData[index].subject_id,
                                          ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      child: Container(
                                        height: 130,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            color: themewhitecolor,
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
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: size.width,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                child: FutureBuilder<String>(
                                                    future: ReusableMethods()
                                                        .subjectImageGet(
                                                            subjectData[index]
                                                                .subject_id),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        String Datara =
                                                            snapshot.data!;

                                                        return Image.network(
                                                          Datara,
                                                          fit: BoxFit.cover,
                                                        );
                                                      } else {
                                                        return Image.network(
                                                          "https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&w=1600",
                                                          fit: BoxFit.cover,
                                                        );
                                                      }
                                                    }),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              child: FutureBuilder<String>(
                                                  future: ReusableMethods()
                                                      .subjectNameGet(
                                                          subjectData[index]
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
                                                        style: const TextStyle(
                                                          color:
                                                              themeblackcolor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      );
                                                    } else {
                                                      return const Text("");
                                                    }
                                                  }),
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
            ),

            //sized box
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Object?> timetableDetailsDialog(
      BuildContext context, Size size, TimetableScheduleModel timetableData) {
    return showAnimatedDialog(
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 700),
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                // backgroundColor: themewhitecolor.withOpacity(0.2),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                titlePadding: const EdgeInsets.all(24),
                actionsPadding: const EdgeInsets.all(0),
                buttonPadding: const EdgeInsets.all(0),
                title: SizedBox(
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Timetable Details",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: themeblackcolor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: themeredcolor,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 150,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: themegreytextcolor,
                              ),
                            ),
                            child: FutureBuilder<String>(
                                future: ReusableMethods()
                                    .subjectImageGet(timetableData.subject_id),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String fetchedImage = snapshot.data!;

                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        fetchedImage,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  } else {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        "https://i.ytimg.com/vi/PAOAjOR6K_Q/maxresdefault.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
//Degree
                          Row(
                            children: [
                              const Icon(Icons.school),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder<String>(
                                  future: ReusableMethods()
                                      .degreeNameGet(timetableData.degree_id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String Datara = snapshot.data!;

                                      return Text(
                                        "Degree: $Datara",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        "Degree: ",
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Semester
                          Row(
                            children: [
                              const Icon(Icons.import_contacts),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder<String>(
                                  future: ReusableMethods().semesterNameGet(
                                      timetableData.semester_id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String Datara = snapshot.data!;

                                      return Text(
                                        "Semester: $Datara",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        "Semester: ",
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          //Teacher Name
                          Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder<String>(
                                  future: ReusableMethods()
                                      .teacherNameGet(timetableData.teacher_id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String Datara = snapshot.data!;

                                      return Text(
                                        "Teacher: $Datara",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        "Teacher: ",
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          //subject
                          Row(
                            children: [
                              const Icon(Icons.description),
                              const SizedBox(
                                width: 10,
                              ),
                              FutureBuilder<String>(
                                  future: ReusableMethods()
                                      .subjectNameGet(timetableData.subject_id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      String Datara = snapshot.data!;

                                      return Text(
                                        "Subject: $Datara",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        "Subject: ",
                                        style: const TextStyle(
                                          color: themeblackcolor,
                                          fontSize: 16,
                                        ),
                                      );
                                    }
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //room no
                          Row(
                            children: [
                              const Icon(Icons.room_preferences),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                timetableData.roomNo,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: themeblackcolor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          //Start Date
                          Row(
                            children: [
                              const Icon(Icons.date_range),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Starttime: ${timetableData.startTime}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: themeblackcolor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          //end time
                          Row(
                            children: [
                              const Icon(Icons.date_range),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Endtime: ${timetableData.endTime}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: themeblackcolor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          //Schedule Date
                          Row(
                            children: [
                              const Icon(Icons.timer),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Schdule Date: ${timetableData.scheduleDate}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: themeblackcolor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ),
              ),
            ));
  }

//filter Subject Timtable
  Stream<List<TimetableScheduleModel>> filterSubjectTimtable(
    String teacher_id,
  ) =>
      FirebaseFirestore.instance
          .collection('subject_timetable')
          .where('teacher_id', isEqualTo: teacher_id)
          .where('status', isEqualTo: 0)
          .orderBy('creationTime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) =>
                  TimetableScheduleModel.fromJson(document.data()))
              .toList());
  Stream<List<TeacherAssignModel>> filter_assigned_subject(String teacher_id) =>
      FirebaseFirestore.instance
          .collection('teacher_assign')
          .where('teacher_id', isEqualTo: teacher_id)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) => TeacherAssignModel.fromJson(document.data()))
              .toList());

  Stream<TeacherModel> filterTeacher(String currentUserUid) {
    return FirebaseFirestore.instance
        .collection('teacher_auth')
        .doc(currentUserUid)
        .snapshots()
        .map((snapshot) => TeacherModel.fromSnap(snapshot));
  }
}
