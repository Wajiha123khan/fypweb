import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/provider/teacher_pro.dart';
import 'package:classchronicalapp/services/notification_model.dart';
import 'package:classchronicalapp/utils/reusable_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeacherNotificationScreen extends StatefulWidget {
  const TeacherNotificationScreen({super.key});

  @override
  State<TeacherNotificationScreen> createState() =>
      _TeacherNotificationScreenState();
}

class _TeacherNotificationScreenState extends State<TeacherNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final teacherModel = Provider.of<TeacherPro>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: const Text(
          "Notifications",
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<NotificationM>>(
            stream: filterNotifications(teacherModel.getTeacherUid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final modelData = snapshot.data!;
                return modelData.isEmpty
                    ? Center(
                        child: Image.asset(
                        "assets/images/png/no_notifications.png",
                        // height: 100,
                      ))
                    : ListView.separated(
                        itemCount: modelData.length,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          var notificationData = modelData[index];

                          return InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Palette.themecolor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      notificationData.data['subject']
                                          .toString()
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: themewhitecolor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.only(left: 8),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: themegreytextcolor,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Teacher Name:  ",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            FutureBuilder<String>(
                                                future: ReusableMethods()
                                                    .teacherNameGet(
                                                        notificationData
                                                            .teacher_id
                                                            .toString()),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    String Datara =
                                                        snapshot.data!;

                                                    return Text(
                                                      Datara.toUpperCase(),
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    );
                                                  } else {
                                                    return const Text(
                                                      "",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    );
                                                  }
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Palette.themecolor,
                                        child: Icon(
                                          Icons.room,
                                          color: themewhitecolor,
                                          size: 15,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text.rich(
                                        TextSpan(
                                          text: "No:  ",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: notificationData
                                                  .data['roomNo'],
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Palette.themecolor,
                                        child: Icon(
                                          CupertinoIcons.calendar,
                                          color: themewhitecolor,
                                          size: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Schedule Date:  ",
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${notificationData.data['startEndTime']} ${notificationData.data['scheduleDate']}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, separator) {
                          return const SizedBox(height: 30);
                        },
                      );
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  //filter notifications
  Stream<List<NotificationM>> filterNotifications(
    String teacher_id,
  ) =>
      FirebaseFirestore.instance
          .collection('notification')
          .where('teacher_id', isEqualTo: teacher_id)
          .where('status', isEqualTo: 0)
          .orderBy('dateTime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) => NotificationM.fromJson(document.data()))
              .toList());
}
