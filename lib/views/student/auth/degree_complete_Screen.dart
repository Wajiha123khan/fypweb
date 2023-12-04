import 'package:classchronicalapp/color.dart';
import 'package:flutter/material.dart';

class DegreeCompleScreen extends StatefulWidget {
  const DegreeCompleScreen({super.key});

  @override
  State<DegreeCompleScreen> createState() => _DegreeCompleScreenState();
}

class _DegreeCompleScreenState extends State<DegreeCompleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "Degree Complete",
              style: TextStyle(
                  fontSize: 22,
                  color: themeblackcolor,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
