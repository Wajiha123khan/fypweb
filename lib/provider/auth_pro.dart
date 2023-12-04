import 'dart:typed_data';
import 'dart:math' as math;
import 'package:classchronicalapp/model/student/student_model.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/splash/splash_screen.dart';
import 'package:classchronicalapp/use_full/show_loading_dailog.dart';
import 'package:classchronicalapp/use_full/storage_mthods.dart';
import 'package:classchronicalapp/widgets/custom_toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPro with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String degree_id = "";
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
      String degree_title,
      String gender,
      String father_name,
      String mother_name,
      String p_phone_num,
      String p_address,
      String p_cnic_beform,
      context) async {
    String errorMessage = "";

    show_loading_dialog(context);
    _firestore
        .collection("degree")
        .where('title', isEqualTo: degree_title.toString())
        .get()
        .then((value) async {
      value.docs.forEach((doc) async {
        degree_id = doc.data()["degree_id"].toString();
        try {
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          String url = await StorageMethods()
              .uploadImageToStoragee('student/pro_image/', _image, false);
          String url_doc = await StorageMethods()
              .uploadImageToStoragee('student/doc/', _doc, true);
          String _randomString = math.Random().nextInt(9999).toString();
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
              semester_id: "",
              father_name: father_name,
              mother_name: mother_name,
              p_phone_num: p_phone_num,
              p_cnic_beform: p_cnic_beform,
              p_address: p_address,
              type: 0,
              date_time: Timestamp.now(),
              profile_image: url,
              doc: url_doc);

          _firestore
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
              errorMessage =
                  "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          Navigator.pop(context);
          customErrorToast("Error", errorMessage, context);
        } catch (e) {
          print(e);
        }

        print("object********1******");
      });
    });
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
            _firestore
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
      UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email.toString(), password: password.toString());

      Navigator.pop(context);
      RouteNavigator.replacementroute(context, const SplashScreen());
      notifyListeners();
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
    }
  }

  String getDegreeId = "";
  String getFirstName = "";
  String getLastName = "";
  String getSemesterId = "";
  int getType = 0;
  void getCurrentUserData() async {
    var collection = FirebaseFirestore.instance.collection('student_auth');

    var docSnapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      getDegreeId = data['degree_id'];

      getFirstName = data['name'];
      getLastName = data['surname'];
      getSemesterId = data['semester_id'];
      getType = int.parse(data['type'].toString());

      print(getSemesterId + " ********************************");
      if (getSemesterId == "") {
        addSemesterFunc(getDegreeId);
      }
      notifyListeners();
    } else {}
  }
}
