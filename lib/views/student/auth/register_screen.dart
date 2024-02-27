import 'dart:developer';

import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/provider/degree_pro.dart';
import 'package:classchronicalapp/utils/pick_image.dart';
import 'package:classchronicalapp/widgets/custom_button.dart';
import 'package:classchronicalapp/widgets/custom_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    final postPro = Provider.of<DegreePro>(context, listen: false);
    postPro.semesterGet.clear();
    super.initState();
  }

  bool hidebottom = false;
  bool visiblePass = true;
  bool visibleRepeatPass = true;
  int value = 0;
  final _formKey = GlobalKey<FormState>();
////personal details
  final TextEditingController nameC = TextEditingController();
  final TextEditingController surnameC = TextEditingController();
  final TextEditingController rollNoC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController phoneNoC = TextEditingController();
  final TextEditingController cnicBformC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController addressC = TextEditingController();

  ///parents details
  final TextEditingController fatherNameC = TextEditingController();
  final TextEditingController motherNameC = TextEditingController();
  final TextEditingController parentPhoneC = TextEditingController();
  final TextEditingController parentAddressC = TextEditingController();
  final TextEditingController parentCnicC = TextEditingController();

  String degreeId = "";
  String semesterId = "";
  final List<String> gender = ['Male', 'Female'];
  String gender_value = "";
  Uint8List? profileImage;
  Future pickProfileImageFunc() async {
    try {
      Uint8List file = await pickImage(ImageSource.gallery);
      setState(() {
        profileImage = file;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

  Uint8List? studentCardDoc;
  Future pickStudentCardImageFunc() async {
    try {
      Uint8List file = await pickImage(ImageSource.gallery);
      setState(() {
        studentCardDoc = file;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final degreeModel = Provider.of<DegreePro>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              height: 260,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/jpg/background.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: themewhitecolor,
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 20,
                          color: Palette.themecolor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Register",
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Create your Account",
                              style: TextStyle(
                                color: themewhitecolor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        profileImage != null
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage: MemoryImage(profileImage!),
                              )
                            : CustomIconButton(
                                onTap: () {
                                  pickProfileImageFunc();
                                },
                                child: const CircleAvatar(
                                  radius: 40,
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: themegreytextcolor,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Personal Details",
                      style: TextStyle(
                        color: themeblackcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: nameC,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Name",
                          labelText: "Name",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: surnameC,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Surname",
                          labelText: "Surname",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Surname is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: rollNoC,
                        keyboardType: const TextInputType.numberWithOptions(),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Roll No",
                          labelText: "Roll No",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Roll No is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: emailC,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        fillColor: themelightgreycolor,
                        filled: true,
                        hintText: "Enter Email",
                        labelText: "Email Address",
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          top: 8,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: phoneNoC,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Phone No",
                          labelText: "Phone No",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone No is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: cnicBformC,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Cnic/BForm",
                          labelText: "Cnic No",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Cnic No is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: passwordC,
                      textInputAction: TextInputAction.next,
                      obscureText: visiblePass,
                      decoration: InputDecoration(
                        fillColor: themelightgreycolor,
                        filled: true,
                        hintText: "Enter Password",
                        labelText: "Password",
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        suffixIcon: CustomIconButton(
                          onTap: () {
                            if (visiblePass == true) {
                              setState(() {
                                visiblePass = false;
                              });
                            } else if (visiblePass == false) {
                              setState(() {
                                visiblePass = true;
                              });
                            }
                          },
                          child: Icon(
                            visiblePass == false
                                ? CupertinoIcons.lock
                                : CupertinoIcons.lock_fill,
                            color: Palette.themecolor,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          top: 8,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      obscureText: visibleRepeatPass,
                      decoration: InputDecoration(
                        fillColor: themelightgreycolor,
                        filled: true,
                        hintText: "Enter Repeat Password",
                        labelText: "Repeat Password",
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                        suffixIcon: CustomIconButton(
                          onTap: () {
                            if (visibleRepeatPass == true) {
                              setState(() {
                                visibleRepeatPass = false;
                              });
                            } else if (visibleRepeatPass == false) {
                              setState(() {
                                visibleRepeatPass = true;
                              });
                            }
                          },
                          child: Icon(
                            visibleRepeatPass == false
                                ? CupertinoIcons.lock
                                : CupertinoIcons.lock_fill,
                            color: Palette.themecolor,
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 12,
                          top: 8,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password is empty.";
                        } else if (value != passwordC.text) {
                          return "Confirm Password doesn't match.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: addressC,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Address",
                          labelText: "Address",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Personal Address is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),

                    DropdownButtonFormField(
                        style: const TextStyle(color: themeblackcolor),
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          hintText: "Select Your Gender",
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          labelText: "Select Gender",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: gender
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: themeblackcolor,
                                  ),
                                )))
                            .toList(),
                        onChanged: (item) {
                          gender_value = item.toString();
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please Select Gender";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    //select degree

                    DropdownButtonFormField(
                        style: const TextStyle(color: themeblackcolor),
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Select Your Degree",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          labelText: "Select Degree",
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          alignLabelWithHint: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: degreeModel.degreeGet
                            .map((item) => DropdownMenuItem(
                                value: item['degree_id'],
                                child: Text(
                                  item['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: themeblackcolor,
                                  ),
                                )))
                            .toList(),
                        onChanged: (item) async {
                          log("degree_value: $item");
                          degreeId = item.toString();
                          final postPro =
                              Provider.of<DegreePro>(context, listen: false);
                          await postPro.getSemestersListFunc(degreeId);
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please Select Degree";
                          }
                          return null;
                        }),

                    Consumer<DegreePro>(builder: ((context, modelValue, child) {
                      return modelValue.semesterGet.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(
                                    style:
                                        const TextStyle(color: themeblackcolor),
                                    decoration: InputDecoration(
                                      fillColor: themelightgreycolor,
                                      filled: true,
                                      hintText: "Select Your Semester",
                                      hintStyle: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      labelText: "Select Semester",
                                      labelStyle: const TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                      alignLabelWithHint: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    items: degreeModel.semesterGet
                                        .map((item) => DropdownMenuItem(
                                            value: item['semester_id'],
                                            child: Text(
                                              item['title'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: themeblackcolor,
                                              ),
                                            )))
                                        .toList(),
                                    onChanged: (item) {
                                      log("semester Id: $item");
                                      semesterId = item.toString();
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "Please Select Semester";
                                      }
                                      return null;
                                    }),
                              ],
                            );
                    })),
                    const Text(
                      "Student ID Card",
                      style: TextStyle(
                        color: themegreytextcolor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        pickStudentCardImageFunc();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: themelightgreycolor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              studentCardDoc != null
                                  ? "Update document"
                                  : "Upload the document",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: themegreytextcolor),
                            ),
                            const Icon(Icons.upload_file,
                                color: themegreytextcolor)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //parent details
                    const Text(
                      "Parent Details",
                      style: TextStyle(
                        color: themeblackcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: fatherNameC,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Father Name",
                          labelText: "Father Name",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Father Name is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: motherNameC,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Mother Name",
                          labelText: "Mother Name",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Mother Name is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: parentPhoneC,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Parent Phone No",
                          labelText: "Parent Phone No",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Parent Phone No is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: parentAddressC,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Parent Address",
                          labelText: "Parent Address",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Parent Address is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: parentCnicC,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          fillColor: themelightgreycolor,
                          filled: true,
                          hintText: "Enter Parent Cnic/BForm",
                          labelText: "Parent Cnic No",
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 12,
                            top: 8,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Parent Cnic No is empty.";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 25,
                    ),

                    CustomButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (profileImage != null) {
                            if (studentCardDoc != null) {
                              final authProvider =
                                  Provider.of<AuthPro>(context, listen: false);

                              authProvider.studentSignupFunc(
                                  profileImage!,
                                  nameC.text,
                                  surnameC.text,
                                  rollNoC.text,
                                  emailC.text,
                                  phoneNoC.text,
                                  cnicBformC.text,
                                  passwordC.text,
                                  addressC.text,
                                  studentCardDoc!,
                                  degreeId,
                                  semesterId,
                                  gender_value,
                                  fatherNameC.text,
                                  motherNameC.text,
                                  parentPhoneC.text,
                                  parentAddressC.text,
                                  parentCnicC.text,
                                  context);
                            } else {
                              showToast(
                                "Please Upload Student ID Card Image",
                                context: context,
                                backgroundColor: themeredcolor,
                                position: StyledToastPosition.center,
                              );
                            }
                          } else {
                            showToast(
                              "Please Select Profile Image",
                              context: context,
                              backgroundColor: themeredcolor,
                              position: StyledToastPosition.center,
                            );
                          }
                        }
                      },
                      height: 55,
                      width: double.infinity,
                      buttoncolor: Palette.themecolor,
                      borderRadius: BorderRadius.circular(12),
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
