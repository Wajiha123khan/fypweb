import 'dart:io';
import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:classchronicalapp/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? image;
  Future cameraImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final pickImagefromgallery = File(image.path);
      setState(() => this.image = pickImagefromgallery);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

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
        title: const Text("Edit Profile"),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomSimpleRoundedButton(
          onTap: () {},
          buttoncolor: Palette.themecolor,
          height: kMinInteractiveDimension,
          width: MediaQuery.of(context).size.width * 0.85,
          borderRadius: BorderRadius.circular(12),
          child: const Text(
            "UPDATE",
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
              Center(
                child: Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(image!),
                          )
                        : const CircleAvatar(
                            backgroundColor: themegreycolor,
                            backgroundImage: AssetImage(
                              "assets/images/jpg/avatar.jpeg",
                            ),
                            radius: 60,
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          cameraImage();
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Palette.themecolor,
                          child: Icon(
                            Icons.edit,
                            color: themewhitecolor,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'First Name',
                icon: const Icon(Icons.abc),
                textEditingController: nameController,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Last Name',
                icon: const Icon(Icons.abc),
                textEditingController: nameController,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Date of Birth',
                icon: const Icon(Icons.date_range),
                textEditingController: nameController,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                hintText: 'Email Address',
                icon: const Icon(Icons.email),
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
