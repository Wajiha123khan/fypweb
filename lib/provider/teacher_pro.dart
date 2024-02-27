import 'dart:developer';
import 'dart:typed_data';

import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/splash/splash_screen.dart';
import 'package:classchronicalapp/utils/show_loading_dailog.dart';
import 'package:classchronicalapp/utils/storage_mthods.dart';
import 'package:classchronicalapp/widgets/custom_toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherPro with ChangeNotifier {
  final current_uid = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  String teacher_uid = "";
  int teacher_value = 0;
  void teacherLoginFunc(email, password, context) async {
    log("$email $password");

    teacher_value = 0;
    firestore
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

  void teacherPasswordUpdateFunc(String teacherId, String teacherEmail,
      String currentPassword, String newPassword, context) async {
    log("$currentPassword $newPassword");
    log("Email: $teacherEmail");

    firestore
        .collection("teacher_auth")
        .where('email', isEqualTo: teacherEmail)
        .where('password', isEqualTo: currentPassword)
        .get()
        .then(
      (value) async {
        try {
          if (value.docs.isNotEmpty) {
            log("doc exists");

            await firestore
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
        } catch (e) {
          debugPrint("Catch Exception: $e");
        }
      },
    );
  }

  //teacher details update
  teacherDetailsUpdateFunc(
      String teacherId,
      Uint8List? selected_imagee,
      String name,
      String surname,
      String qualification,
      String aboutMe,
      context) async {
    show_loading_dialog(context);

    if (selected_imagee != null) {
      String url = await StorageMethods()
          .uploadImageToStoragee('teacher_auth/image/', selected_imagee, false);

      await firestore
          .collection("teacher_auth")
          .doc(teacherId)
          .update({"profile": url});
    }

    await firestore
        .collection("teacher_auth")
        .doc(
          teacherId,
        )
        .update({
      "name": name,
      "surname": surname,
      "qualification": qualification,
      "aboutMe": aboutMe
    }).then((value) async {
      getTeacherData(teacherId);
      notifyListeners();
      customSuccessToast(
          "Updated", "Your Profile has been Updated Successfulyy!", context);
      Navigator.pop(context);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Navigator.pop(context);

      debugPrint(error.toString());
    });
  }

  String getTeacherUid = "";
  String getEmail = "";
  String getfirstName = "";
  String getLastName = "";
  String getProfile = "";
  String getQualification = "";
  String getAboutMe = "";
  void getTeacherData(teacher_uid) async {
    notifyListeners();
    var collection = FirebaseFirestore.instance.collection('teacher_auth');

    var docSnapshot = await collection.doc(teacher_uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      getTeacherUid = data['uid'];
      getEmail = data['email'];
      getfirstName = data['first_name'];
      getLastName = data['last_name'];
      getProfile = data['profile'];
      getQualification = data['qualification'];
      getAboutMe = data['aboutMe'];

      notifyListeners();
    } else {}
  }

//updating device token
  void updateTeacherToken(String userUid, token) async {
    log("Device Token: $token");

    log("userid: $userUid");
    await firestore
        .collection("teacher_auth")
        .doc(
          userUid,
        )
        .update({
      "token": token,
    }).then((value) async {
      notifyListeners();
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
