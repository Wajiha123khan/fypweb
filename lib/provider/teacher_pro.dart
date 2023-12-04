import 'dart:developer';

import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/splash/splash_screen.dart';
import 'package:classchronicalapp/use_full/show_loading_dailog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherPro with ChangeNotifier {
  final current_uid = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String teacher_uid = "";
  int teacher_value = 0;
  void teacherLoginFunc(email, password, context) async {
    log("$email $password");

    teacher_value = 0;
    _firestore
        .collection("teacher_auth")
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then(
      (value) async {
        value.docs.forEach((doc) async {
          teacher_value = 1;
          log("teacher_value $teacher_value");

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('teacher_uid', doc.data()["uid"].toString());

          debugPrint('doc.data()["uid"]');
          debugPrint(doc.data()["uid"]);
          log("in body");

          RouteNavigator.replacementroute(context, SplashScreen());
        });
      },
    ).whenComplete(() {
      if (teacher_value == 0) {
        showToast('Please enter valid email password',
            context: context, position: StyledToastPosition.center);
      }
    });
  }

  teacherDetailsUpdateFunc(String teacherId, String firstName, String lastName,
      String qualification, context) async {
    show_loading_dialog(context);

    log("teacherId: $teacherId");
    try {
      await _firestore
          .collection("teacher_auth")
          .doc(
            teacherId,
          )
          .update({
        "first_name": firstName,
        "last_name": lastName,
        "qualification": qualification,
      }).then((value) {
        get_user_data(teacherId);
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void teacherPasswordUpdateFunc(String teacherId, String teacherEmail,
      String currentPassword, String newPassword, context) async {
    log("$currentPassword $newPassword");
    log("Email: $teacherEmail");

    _firestore
        .collection("teacher_auth")
        .where('email', isEqualTo: teacherEmail)
        .where('password', isEqualTo: currentPassword)
        .get()
        .then(
      (value) async {
        try {
          if (value.docs.isNotEmpty) {
            log("doc exists");

            await _firestore
                .collection("teacher_auth")
                .doc(
                  teacherId,
                )
                .update({
              "password": newPassword,
            }).then((value) async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              await prefs.remove('teacher_uid');
              RouteNavigator.replacementroute(
                context,
                const SplashScreen(),
              );
            }).onError((error, stackTrace) {
              debugPrint(error.toString());
            });
          } else {
            showToast('Current password is wrong!',
                context: context, position: StyledToastPosition.center);
          }
        } catch (e) {}
      },
    );
  }

  String get_email = "";
  String get_first_name = "";
  String get_last_name = "";
  String get_profile = "";
  String get_qualification = "";
  void get_user_data(teacher_uid) async {
    notifyListeners();
    var collection = FirebaseFirestore.instance.collection('teacher_auth');

    var docSnapshot = await collection.doc(teacher_uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      get_email = data['email'];
      get_first_name = data['first_name'];
      get_last_name = data['last_name'];
      get_profile = data['profile'];
      get_qualification = data['qualification'];

      notifyListeners();
    } else {}
  }
}
