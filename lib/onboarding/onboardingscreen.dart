import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/person_category_screen.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:classchronicalapp/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  _storeOnBoarding() async {
    int isViewed = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt('onboarding', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: const [
                CreatePage(
                  image: 'assets/images/png/onboard-1.png',
                  title: "One",
                  subtitle:
                      "Welcome to Class Chronical! Elevate your teaching journey by creating your account and exploring a world of educational possibilities.",
                  color: Palette.themecolor,
                ),
                CreatePage(
                  image: 'assets/images/png/onboard-2.png',
                  title: "Two",
                  subtitle:
                      "Customize your courses with ease! Tailor content, set assessments, and personalize the learning experience to captivate your students.",
                  color: Palette.themecolor,
                ),
                CreatePage(
                  image: 'assets/images/png/onboard-3.png',
                  title: "Three",
                  subtitle:
                      "Ready to inspire? Launch your first course, connect with learners, and watch your teaching ambitions come to life on Class Chronical.",
                  color: Palette.themecolor,
                ),
              ],
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: _buildIndicator(),
                  ),
                  CustomIconButton(
                    onTap: () {
                      setState(() {
                        if (currentIndex == 0) {
                          _pageController.jumpToPage(1);
                        } else if (currentIndex == 1) {
                          _pageController.jumpToPage(2);
                        } else if (currentIndex == 2) {
                          _storeOnBoarding();
                          RouteNavigator.pushandremoveroute(
                            context,
                            const PersonCategoryScreen(),
                          );
                        }
                      });
                    },
                    child: currentIndex == 2
                        ? AnimatedContainer(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Palette.themecolor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            duration: const Duration(milliseconds: 500),
                            child: Row(
                              children: const [
                                Text(
                                  "Get Started",
                                  style: TextStyle(
                                    color: themewhitecolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: themewhitecolor,
                                ),
                              ],
                            ),
                          )
                        : AnimatedContainer(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 20,
                            ),
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: Palette.themecolor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: themewhitecolor,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Extra Widgets

  //Create the indicator decorations widget
  Widget _activeindicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Palette.themecolor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _inactiveindicator(bool isInActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isInActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: themegreycolor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_activeindicator(true));
      } else {
        indicators.add(_inactiveindicator(false));
      }
    }

    return indicators;
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title;
  final Color color;
  final String subtitle;
  const CreatePage(
      {Key? key,
      required this.image,
      required this.title,
      required this.color,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height / 100 * 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
                height: 300,
                width: size.width / 100 * 80,
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(
          flex: 5,
        ),
      ],
    );
  }
}
