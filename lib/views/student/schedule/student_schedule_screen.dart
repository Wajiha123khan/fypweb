import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/model/student/timetable_schedule_model.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/utils/reusable_methods.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

class StudentScheduleScreen extends StatefulWidget {
  const StudentScheduleScreen({super.key});

  @override
  State<StudentScheduleScreen> createState() => _StudentScheduleScreenState();
}

class _StudentScheduleScreenState extends State<StudentScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthPro>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              themewhitecolor,
              themewhitecolor,
              themewhitecolor,
              Palette.themecolor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                Stack(
                  alignment: Alignment.center,
                  children: const [
                    Text(
                      "Class Schedule",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<List<TimetableScheduleModel>>(
                    stream: filterSubjectTimtable(
                        authModel.getDegreeId, authModel.getSemesterId),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final modelData = snapshot.data!;
                        return modelData.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height / 100 * 10,
                                  ),
                                  Center(
                                    child: Image.asset(
                                      "assets/images/png/no_timetable_available.png",
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height / 100 * 3,
                                  ),
                                  Text(
                                    "No Schedules for class",
                                    style: const TextStyle(
                                      color: themeblackcolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: modelData.length,
                                itemBuilder: (context, index) {
                                  var timetableData = modelData[index];
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: themewhitecolor,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: themegreycolor,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        FutureBuilder<String>(
                                            future: ReusableMethods()
                                                .subjectImageGet(
                                                    timetableData.subject_id),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                String Datara = snapshot.data!;

                                                return CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(Datara));
                                              } else {
                                                return const CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      "https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&w=1600"),
                                                );
                                              }
                                            }),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${timetableData.startTime} - ${timetableData.endTime}",
                                              style: const TextStyle(
                                                color: themeblackcolor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            FutureBuilder<String>(
                                                future: ReusableMethods()
                                                    .subjectNameGet(
                                                        timetableData
                                                            .subject_id),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    String Datara =
                                                        snapshot.data!;

                                                    return Text(
                                                      Datara,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color:
                                                            themegreytextcolor,
                                                        fontSize: 13,
                                                      ),
                                                    );
                                                  } else {
                                                    return const Text("");
                                                  }
                                                }),
                                          ],
                                        ),
                                        const Spacer(),
                                        CustomSimpleRoundedButton(
                                          onTap: () {
                                            timetableDetailsDialog(
                                                context, size, timetableData);
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
                                    ),
                                  );
                                },
                                separatorBuilder: (context, separator) {
                                  return const SizedBox(
                                    height: 15,
                                  );
                                },
                              );
                      } else {
                        return Container();
                      }
                    }),
              ]),
            ),
          ),
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
          String degree_id, String semester_id) =>
      FirebaseFirestore.instance
          .collection('subject_timetable')
          .where('degree_id', isEqualTo: degree_id)
          .where('semester_id', isEqualTo: semester_id)
          .orderBy('creationTime', descending: true)
          .where('status', isEqualTo: 0)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) =>
                  TimetableScheduleModel.fromJson(document.data()))
              .toList());
}
