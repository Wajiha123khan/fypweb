import 'package:classchronicalapp/navigation/student_nav_bar.dart';
import 'package:classchronicalapp/navigation/teacher_nav_bar.dart';
import 'package:classchronicalapp/person_category_screen.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/provider/teacher_pro.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/views/student/auth/degree_complete_Screen.dart';
import 'package:classchronicalapp/views/student/auth/waiting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  void islogin(context) async {
    final authProvider = Provider.of<AuthPro>(context, listen: false);

    if (FirebaseAuth.instance.currentUser != null) {
      authProvider.getCurrentUserData();
      await Future.delayed(const Duration(seconds: 2));
      if (authProvider.getType == 0) {
        RouteNavigator.pushandremoveroute(context,
            const StudentWaitingScreen(message: "Waiting For Approval"));
      } else if (authProvider.getType == 2) {
        RouteNavigator.pushandremoveroute(context,
            const StudentWaitingScreen(message: "Not Approve By University"));
      } else {
        if (authProvider.getSemesterId == "pass") {
          RouteNavigator.pushandremoveroute(
              context, const DegreeCompleScreen());
        } else {
          RouteNavigator.pushandremoveroute(context, const StudentNavBar());
        }
      }
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? teacher_uid = prefs.getString('teacher_uid');

      if (teacher_uid != null) {
        RouteNavigator.pushandremoveroute(context, const TeacherNavBar());
        final teacherProvider = Provider.of<TeacherPro>(context, listen: false);
        teacherProvider.teacher_uid = teacher_uid;
        teacherProvider.get_user_data(teacher_uid);
      } else {
        RouteNavigator.pushandremoveroute(
            context, const PersonCategoryScreen());
      }
    }
  }
}
