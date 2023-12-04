import 'dart:async';

import 'package:classchronicalapp/provider/degree_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final degreeProvider = Provider.of<DegreePro>(context, listen: false);
    degreeProvider.Get_degree_drop_down_fun();

    Timer(const Duration(seconds: 3), () {
      SplashServices().islogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/images/png/logo.png")),
    );
  }
}
