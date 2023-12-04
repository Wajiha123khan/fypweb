import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:classchronicalapp/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: themegreycolor,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 20,
                color: Palette.themecolor,
              ),
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: const Text("Change Password"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomSimpleRoundedButton(
          onTap: () {
            // RouteNavigator.route(context, PaymentMethods());
          },
          buttoncolor: Palette.themecolor,
          height: kMinInteractiveDimension,
          width: MediaQuery.of(context).size.width * 0.85,
          borderRadius: BorderRadius.circular(12),
          child: const Text(
            "Update",
            style: TextStyle(
              color: themewhitecolor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/png/chat.png",
                height: 250,
              ),
              const SizedBox(
                height: 60,
              ),
              TextFieldInput(
                hintText: 'Old Password',
                icon: const Icon(Icons.password),
                textEditingController: nameController,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'New Password',
                icon: const Icon(Icons.password),
                textEditingController: nameController,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Confirm New Password',
                icon: const Icon(Icons.password),
                textEditingController: nameController,
                textInputType: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
