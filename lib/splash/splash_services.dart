import 'package:classchronicalapp/navigation/student_nav_bar.dart';
import 'package:classchronicalapp/navigation/teacher_nav_bar.dart';
import 'package:classchronicalapp/onboarding/onboardingscreen.dart';
import 'package:classchronicalapp/person_category_screen.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/provider/teacher_pro.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/services/notification_service.dart';
import 'package:classchronicalapp/views/student/auth/degree_complete_Screen.dart';
import 'package:classchronicalapp/views/student/auth/waiting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  void islogin(context) async {
    NotificationServices notificationServices = NotificationServices();
    final authProvider = Provider.of<AuthPro>(context, listen: false);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? isViewed;
    //NOTIFICATION SERVICES
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);

    if (FirebaseAuth.instance.currentUser != null) {
      authProvider.getCurrentUserData();
      notificationServices.getDeviceToken().then((value) {
        // final post = Provider.of<auth_pro>(context, listen: false);
        authProvider.updateToken(FirebaseAuth.instance.currentUser!.uid, value);
      });
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
      final String? teacher_uid = prefs.getString('teacher_uid');
      final teacherProvider = Provider.of<TeacherPro>(context, listen: false);
      if (teacher_uid != null) {
        notificationServices.getDeviceToken().then((value) {
          teacherProvider.updateTeacherToken(teacher_uid, value);
        });
        RouteNavigator.pushandremoveroute(context, const TeacherNavBar());

        teacherProvider.teacher_uid = teacher_uid;
        teacherProvider.getTeacherData(teacher_uid);
      } else {
        isViewed = prefs.getInt('onboarding');
        RouteNavigator.pushandremoveroute(context,
            isViewed != 0 ? const OnboardingScreen() : PersonCategoryScreen());
      }
    }
  }
}
