import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/model/student/timetable_schedule_model.dart';
import 'package:classchronicalapp/provider/notification_pro.dart';
import 'package:classchronicalapp/provider/teacher_pro.dart';
import 'package:classchronicalapp/utils/reusable_methods.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TeacherScheduleScreen extends StatefulWidget {
  const TeacherScheduleScreen({super.key});

  @override
  State<TeacherScheduleScreen> createState() => _TeacherScheduleScreenState();
}

class _TeacherScheduleScreenState extends State<TeacherScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController startTimeC = TextEditingController();
  final TextEditingController endTimeC = TextEditingController();
  final TextEditingController scheduleDateC = TextEditingController();

//room list slack
  String selectedRoomValue = "";
  int roomValue = 0;
  var roomList = [
    'Select Room No',
    'Room No 01',
    'Room No 02',
    'Room No 03',
    'Room No 04',
    'Room No 05',
    'Room No 06',
    'Room No 07',
    'Room No 08',
    'Room No 09',
    'Room No 10',
    'Room No 11',
    'Room No 12',
    'Room No 13',
    'Room No 14',
    'Room No 15',
    'Lab No 01',
    'Lab No 02',
    'Lab No 03',
    'Lab No 04',
    'Lab No 05',
    'Lab No 06',
    'Lab No 07',
    'Lab No 08',
    'Lab No 09',
    'Lab No 10',
  ];
  @override
  Widget build(BuildContext context) {
    final teacherModel = Provider.of<TeacherPro>(context, listen: false);

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
                      teacherModel.getTeacherUid,
                    ),
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomSimpleRoundedButton(
                                                onTap: () {
                                                  timetableDetailsDialog(
                                                      context,
                                                      size,
                                                      timetableData);
                                                },
                                                height: size.height / 100 * 5,
                                                width: size.width / 100 * 10,
                                                buttoncolor: Palette.themecolor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Palette.themecolor,
                                                  size: 25,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            CustomSimpleRoundedButton(
                                                onTap: () {
                                                  timetableEditDetailsDialog(
                                                      context,
                                                      size,
                                                      timetableData);
                                                },
                                                height: size.height / 100 * 5,
                                                width: size.width / 100 * 10,
                                                buttoncolor: Palette.themecolor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: themeredcolor,
                                                  size: 25,
                                                )),
                                          ],
                                        )
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

  Future<Object?> timetableEditDetailsDialog(
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Update Timetable",
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
                            const SizedBox(height: 30),
                            SizedBox(
                              width: size.width,
                              child: TextFormField(
                                style: const TextStyle(color: themeblackcolor),
                                controller: startTimeC,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.date_range),
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(15),
                                  labelText: "Start Time",
                                  labelStyle: TextStyle(color: themeblackcolor),
                                  isDense: true,
                                ),
                                readOnly: true,
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime:
                                          const TimeOfDay(hour: 10, minute: 47),
                                      builder: (context, Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: false),
                                          child: child!,
                                        );
                                      });

                                  if (pickedTime != null) {
                                    debugPrint(
                                        "Parsed Time: ${pickedTime.format(context)}"); //output 10:51 PM
                                    setState(() {
                                      startTimeC.text =
                                          pickedTime.format(context);
                                    });
                                  } else {
                                    print("Time is not selected");
                                  }
                                },
                                validator: ((value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Please Select the Start time";
                                  }
                                  return null;
                                }),
                              ),
                            ),
                            const SizedBox(height: 5),

                            //end time
                            SizedBox(
                              width: size.width,
                              child: TextFormField(
                                style: const TextStyle(color: themeblackcolor),
                                controller: endTimeC,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.date_range),
                                  contentPadding: EdgeInsets.all(15),
                                  labelText: "End Time",
                                  labelStyle: TextStyle(color: themeblackcolor),
                                  isDense: true,
                                ),
                                readOnly: true,
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime:
                                          const TimeOfDay(hour: 10, minute: 47),
                                      builder: (context, Widget? child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                              alwaysUse24HourFormat: false),
                                          child: child!,
                                        );
                                      });

                                  if (pickedTime != null) {
                                    debugPrint(
                                        "Parsed Time: ${pickedTime.format(context)}"); //output 10:51 PM
                                    setState(() {
                                      endTimeC.text =
                                          pickedTime.format(context);
                                    });
                                  } else {
                                    print("Time is not selected");
                                  }
                                },
                                validator: ((value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Please Select the End time";
                                  }
                                  return null;
                                }),
                              ),
                            ),
                            const SizedBox(height: 5),

                            //schedule date -- room no
                            SizedBox(
                              width: size.width,
                              child: TextFormField(
                                  autofocus: false,
                                  controller: scheduleDateC,
                                  keyboardType: TextInputType.none,
                                  style:
                                      const TextStyle(color: themeblackcolor),
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.timer),
                                      contentPadding: EdgeInsets.all(15),
                                      isDense: true,
                                      labelText: "Schedule Date",
                                      labelStyle:
                                          TextStyle(color: themeblackcolor),
                                      hintStyle: TextStyle(fontSize: 12)),
                                  onTap: () async {
                                    DateTime? pickeddate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (pickeddate != null) {
                                      setState(() {
                                        scheduleDateC.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickeddate);
                                        debugPrint(
                                            "scheduleDateC: ${scheduleDateC.text}");
                                      });
                                    }
                                  },
                                  validator: ((value) {
                                    if (value!.isEmpty && value == "") {
                                      return "Please Select the date";
                                    }
                                    return null;
                                  })),
                            ),
                            const SizedBox(height: 5),

                            SizedBox(
                                width: size.width,
                                child: DropdownButtonFormField(
                                  borderRadius: BorderRadius.circular(15),
                                  menuMaxHeight: 200,
                                  elevation: 6,
                                  dropdownColor: themewhitecolor,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconEnabledColor: themegreytextcolor,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: themeblackcolor.withOpacity(
                                            0.3,
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      )),
                                  value: roomList[0],
                                  items: roomList
                                      .map((item) => DropdownMenuItem(
                                          value: item.toString(),
                                          child: Text(
                                            item.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: themeblackcolor,
                                            ),
                                          )))
                                      .toList(),
                                  onChanged: (item) => setState(() {
                                    selectedRoomValue = item.toString();
                                    debugPrint(
                                        "selectedRoomValue: $selectedRoomValue");
                                  }),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please Select Room No';
                                    } else if (value == 'Select Room No') {
                                      return 'Please Select Room No';
                                    }
                                    return null;
                                  },
                                )),

                            const SizedBox(
                              height: 20,
                            ),
                            CustomSimpleRoundedButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final notificationPro =
                                      Provider.of<NotificationPro>(context,
                                          listen: false);
                                  notificationPro
                                      .updateTimetableFromTeacherSideFunc(
                                          timetableData.timetable_id,
                                          timetableData.degree_id,
                                          timetableData.semester_id,
                                          timetableData.subject_id,
                                          timetableData.teacher_id,
                                          startTimeC.text,
                                          endTimeC.text,
                                          scheduleDateC.text,
                                          selectedRoomValue,
                                          context);
                                  //clearing variables
                                  setState(() {
                                    startTimeC.clear();
                                    endTimeC.clear();
                                    scheduleDateC.clear();
                                    selectedRoomValue = "";
                                  });
                                }
                              },
                              height: 50,
                              width: size.width / 100 * 80,
                              buttoncolor: Palette.themecolor,
                              borderRadius: BorderRadius.circular(12),
                              child: const Text(
                                "Update",
                                style: TextStyle(
                                  color: themewhitecolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ));
  }

  //filter Subject Timtable
  Stream<List<TimetableScheduleModel>> filterSubjectTimtable(
    String teacherId,
  ) =>
      FirebaseFirestore.instance
          .collection('subject_timetable')
          .where('teacher_id', isEqualTo: teacherId)
          .where('status', isEqualTo: 0)
          .orderBy('creationTime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) =>
                  TimetableScheduleModel.fromJson(document.data()))
              .toList());
}
