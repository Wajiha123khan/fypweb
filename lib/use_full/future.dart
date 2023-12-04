import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
//for teacher
String ProfileImage = "";
Future<String> user_image_get(String userid, String condition) async {
  var collection =
      _firestore.collection((condition == '1') ? "students" : "teachers");
  // .collection("teachers");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    ProfileImage = data['profile_image'];
  } else {}
  return ProfileImage;
}

String user_name = "";
Future<String> user_name_get(String userid, String condition) async {
  var collection = FirebaseFirestore.instance
      .collection((condition == '1') ? "students" : "teachers");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    user_name = data['full_name'];
  } else {}
  return user_name;
}

//
String group_username = "";
Future<String> group_user_name_get(
  String senderID,
) async {
  var collection = FirebaseFirestore.instance.collection("teacher_auth");
  var docSnapshot = await collection.doc(senderID).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    group_username = data['first_name'] + " " + data['last_name'];
  } else {
    var collection = FirebaseFirestore.instance.collection("student_auth");
    var docSnapshot = await collection.doc(senderID).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      group_username = data['name'] + " " + data['surname'];
      return group_username;
    }
  }
  return group_username;
}

///for testing
String username = "";
Future<String> usernameGet(String userid) async {
  var collection = FirebaseFirestore.instance.collection("student_auth");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    username = data['name'] + " " + data['surname'];
  } else {}
  return username;
}

String email = "";
Future<String> emailGet(String userid) async {
  var collection = FirebaseFirestore.instance.collection("students");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    email = data['email'];
  } else {}
  return email;
}

String userimage = "";
Future<String> userimageGet(String userid) async {
  var collection = FirebaseFirestore.instance.collection("student_auth");
  var docSnapshot = await collection.doc(userid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    userimage = data['profile_image'];
  } else {}
  return userimage;
}

String teacherid = "";
Future<String> teacherUidGet() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? teacher_uid = prefs.getString('teacher_uid');
  var collection = FirebaseFirestore.instance.collection("teachers");
  var docSnapshot = await collection.where('uid', isEqualTo: teacher_uid).get();
  if (docSnapshot.docs.isNotEmpty) {
    Map<String, dynamic> data = docSnapshot.docs.first.data();
    log("data $data");
    teacherid = data['uid'];
    log("teacherid $teacherid}");
  } else {}
  return teacherid;
}
