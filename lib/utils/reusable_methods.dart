import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReusableMethods {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
//Futures for Students
  String studentName = "";
  Future<String> studentNameGet(String studentId) async {
    var collection = firestore.collection("student_auth");
    var docSnapshot = await collection.doc(studentId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      studentName = data['name'] + " " + data['surname'];
    } else {}
    return studentName;
  }

  String studentImage = "";
  Future<String> studentImageGet(String studentId) async {
    var collection = firestore.collection("student_auth");
    var docSnapshot = await collection.doc(studentId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      studentImage = data['profile_image'];
    } else {}
    return studentImage;
  }

  String studentRollNumber = "";
  Future<String> studentRollNumberGet(String studentId) async {
    var collection = firestore.collection("student_auth");
    var docSnapshot = await collection.doc(studentId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      studentRollNumber = data['roll_no'];
    } else {}
    return studentRollNumber;
  }

  String fatherName = "";
  Future<String> fatherNameGet(String studentId) async {
    var collection = firestore.collection("student_auth");
    var docSnapshot = await collection.doc(studentId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      fatherName = data['father_name'];
    } else {}
    return fatherName;
  }

//Course Futures
  String degreeTitle = "";
  Future<String> degreeNameGet(String degreeId) async {
    var collection = firestore.collection("degree");
    var docSnapshot = await collection.doc(degreeId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      degreeTitle = data['title'];
      print("degreeTitle***********************");
      print(degreeTitle);
    } else {}
    return degreeTitle;
  }

  String semesterTitle = "";
  Future<String> semesterNameGet(String semesterId) async {
    var collection = firestore.collection("semester");
    var docSnapshot = await collection.doc(semesterId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      semesterTitle = data['title'];
    } else {}
    return semesterTitle;
  }

  String subjectName = "";
  Future<String> subjectNameGet(String subjectId) async {
    var collection = firestore.collection("subject");
    var docSnapshot = await collection.doc(subjectId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      subjectName = data['title'];
      print("subjectName***********************");
      print(subjectName);
    } else {}
    return subjectName;
  }

  String subjectImg = "";
  Future<String> subjectImageGet(String subjectId) async {
    var collection = firestore.collection("subject");
    var docSnapshot = await collection.doc(subjectId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      subjectImg = data['subject_image'];
    } else {}
    return subjectImg;
  }

  String teacherName = "";
  Future<String> teacherNameGet(String teacherId) async {
    var collection = firestore.collection("teacher_auth");
    var docSnapshot = await collection.doc(teacherId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      teacherName = data['first_name'] + " " + data['last_name'];
    } else {}
    return teacherName;
  }

  String teacherImage = "";
  Future<String> teacherImageGet(String teacherId) async {
    var collection = firestore.collection("teacher_auth");
    var docSnapshot = await collection.doc(teacherId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      teacherImage = data['profile'];
    } else {}
    return teacherImage;
  }

  String teacherEmail = "";
  Future<String> teacherEmailGet(String teacherId) async {
    var collection = firestore.collection("teacher_auth");
    var docSnapshot = await collection.doc(teacherId).get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;
      teacherEmail = data['email'];
    } else {}
    return teacherEmail;
  }
}
