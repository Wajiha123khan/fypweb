import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DegreePro with ChangeNotifier {
  // final _current_uid = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  List degree_get = [];
  Get_degree_drop_down_fun() async {
    degree_get = [];

    FirebaseFirestore.instance.collection("degree").get().then(
      (value) async {
        value.docs.forEach((doc) {
          degree_get.add(doc.data()["title"]);
          notifyListeners();
        });
      },
    );
  }
}
