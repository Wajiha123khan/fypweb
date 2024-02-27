import 'dart:developer';
import 'dart:typed_data';
import 'package:classchronicalapp/model/student/student_model.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/splash/splash_screen.dart';
import 'package:classchronicalapp/utils/show_loading_dailog.dart';
import 'package:classchronicalapp/utils/storage_mthods.dart';
import 'package:classchronicalapp/widgets/custom_toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPro with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  studentSignupFunc(
      Uint8List _image,
      String name,
      String surname,
      String roll_no,
      String email,
      String phone_num,
      String cnicBform,
      String password,
      String address,
      Uint8List _doc,
      String degree_id,
      String semester_id,
      String gender,
      String father_name,
      String mother_name,
      String p_phone_num,
      String p_address,
      String p_cnic_beform,
      context) async {
    String errorMessage = "";

    show_loading_dialog(context);
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String url = await StorageMethods()
          .uploadImageToStoragee('student/pro_image/', _image, false);
      String url_doc = await StorageMethods()
          .uploadImageToStoragee('student/doc/', _doc, true);
      StudentModel _model = StudentModel(
          uid: cred.user!.uid,
          name: name,
          surname: surname,
          roll_no: roll_no,
          email: email,
          phone_num: phone_num,
          cnic_beform: cnicBform,
          password: password,
          address: address,
          gender: gender,
          degree_id: degree_id,
          semester_id: semester_id,
          father_name: father_name,
          mother_name: mother_name,
          p_phone_num: p_phone_num,
          p_cnic_beform: p_cnic_beform,
          p_address: p_address,
          type: 0,
          date_time: Timestamp.now(),
          profile_image: url,
          doc: url_doc,
          token: "");

      firestore
          .collection("student_auth")
          .doc(
            cred.user!.uid,
          )
          .set(_model.toJson())
          .then((value) {
        getCurrentUserData();

        RouteNavigator.route(context, const SplashScreen());
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "email-already-in-use":
          errorMessage = "This Email is Already Taken.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Navigator.pop(context);
      customErrorToast("Error", errorMessage, context);
    } catch (e) {
      print(e);
    }
  }

  void addSemesterFunc(String degreeId) {
    FirebaseFirestore.instance
        .collection("semester")
        .where('degree_id', isEqualTo: degreeId.toString())
        .where('index', isEqualTo: 1)
        .get()
        .then(
      (value) async {
        value.docs.forEach(
          (doc) {
            firestore
                .collection("student_auth")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({'semester_id': doc.data()["semester_id"].toString()});
          },
        );
      },
    );
  }

  void studentLoginFunc(email, password, context) async {
    String errorMessage = "";
    try {
      show_loading_dialog(context);
      await auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());

      Navigator.pop(context);
      RouteNavigator.replacementroute(context, const SplashScreen());
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "invalid-credential":
          errorMessage = "Please check you email or password.";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "email-already-in-use":
          errorMessage = "This Email is Already Taken.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      Navigator.pop(context);
      customErrorToast("Error", errorMessage, context);
    }
  }

  studentDetailsUpdateFunc(
      String userId,
      Uint8List? selected_imagee,
      String name,
      String surname,
      String phone_num,
      String cnicBform,
      context) async {
    // try {
    show_loading_dialog(context);

    if (selected_imagee != null) {
      String url = await StorageMethods()
          .uploadImageToStoragee('student/pro_image/', selected_imagee, false);

      await firestore
          .collection("student_auth")
          .doc(userId)
          .update({"profile_image": url});
    }

    await firestore
        .collection("student_auth")
        .doc(
          userId,
        )
        .update({
      "name": name,
      "surname": surname,
      "phone_num": phone_num,
      "cnicBform": cnicBform
    }).then((value) async {
      getCurrentUserData();
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

//student password update func
  studentPasswordUpdateFunc(
      String userId, String oldPassword, String newPassword, context) async {
    try {
      show_loading_dialog(context);

      var docSnapshot =
          await firestore.collection("student_auth").doc(userId).get();

      if (docSnapshot.exists) {
        log("exits");
        Map<String, dynamic> data = docSnapshot.data()!;
        if (data['password'].toString() == oldPassword) {
          log("password match");

          await auth.currentUser!.updatePassword(newPassword);

          await firestore.collection("student_auth").doc(userId).update(
            {"password": newPassword},
          );
          // customSuccessToast(
          //     "Password Change",
          //     "Your password has been changed successfuly\nEnter your new password to continue!",
          //     context);
          FirebaseAuth.instance.signOut().then((value) async {
            // Future.delayed(const Duration(seconds: 2));

            RouteNavigator.pushandremoveroute(
              context,
              const SplashScreen(),
            );
          });
        } else {
          Navigator.pop(context);
          customSuccessToast(
              "Password Change",
              "The Old password you entered is not correct\nEnter your correct password to change!",
              context);
        }
      } else {
        log("not exits");

        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);

      debugPrint("Catch Exception: $e");
    }
    // Navigator.pop(context);
  }

//current user details fetch
  String getUserUid = "";
  String getProfileImage = "";
  String getFirstName = "";
  String getLastName = "";
  String getPhoneNo = "";
  String getCnicBform = "";
  String getDegreeId = "";
  String getSemesterId = "";
  int getType = 0;
  void getCurrentUserData() async {
    var collection = FirebaseFirestore.instance.collection('student_auth');

    var docSnapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      getUserUid = data['uid'];
      getProfileImage = data['profile_image'];
      getFirstName = data['name'];
      getLastName = data['surname'];
      getPhoneNo = data['phone_num'];
      getCnicBform = data['cnic_beform'];
      getDegreeId = data['degree_id'];
      getSemesterId = data['semester_id'];
      getType = int.parse(data['type'].toString());

      // print(getSemesterId + " ********************************");
      // if (getSemesterId == "") {
      //   addSemesterFunc(getDegreeId);
      // }
      notifyListeners();
    } else {}
  }

//updating device token
  void updateToken(String userUid, token) async {
    log("Device Token: $token");

    log("userid: $userUid");
    await firestore
        .collection("student_auth")
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
