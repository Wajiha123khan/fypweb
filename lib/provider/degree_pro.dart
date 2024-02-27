import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DegreePro with ChangeNotifier {

  //fetching degrees
  List degreeGet = [];
  Future<void> getDegreesListFunc() async {
    degreeGet = [];

    await FirebaseFirestore.instance.collection("degree").get().then(
      (value) async {
        value.docs.forEach((doc) {
          // degree_get.add(doc.data()["title"]);
          degreeGet.add(doc.data());
          notifyListeners();
        });
      },
    );
  }

  List semesterGet = [];
  Future<void> getSemestersListFunc(String degreeId) async {
    log("degreeId: $degreeId");
    semesterGet = [];

    await FirebaseFirestore.instance
        .collection("semester")
        .where("degree_id", isEqualTo: degreeId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        log("element: ${element.data()}");
        semesterGet.add(element.data());
        notifyListeners();
      });
    });
    // await FirebaseFirestore.instance
    //     .collection("semester")
    //     // .where("degree_id", isEqualTo: degreeId)
    //     .get()
    //     .then(
    //   (value) async {
    //     value.docs.forEach((doc) {
    //       log("doc data: ${doc.data()}");
    //       semesterGet.add(doc.data());
    //       notifyListeners();
    //     });
    //   },
    // );
  }

  // List semester_get = [];
  // Get_semester_drop_down_fun(String degreeId) async {
  //   semester_get = [];

  //   FirebaseFirestore.instance
  //       .collection("degree")
  //       .where("degree_id", isEqualTo: degreeId)
  //       .get()
  //       .then(
  //     (value) async {
  //       value.docs.forEach((doc) {
  //         // degree_get.add(doc.data()["title"]);
  //         semester_get.add(doc.data());
  //         notifyListeners();
  //       });
  //     },
  //   );
  // }
}
