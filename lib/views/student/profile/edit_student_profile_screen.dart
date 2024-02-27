import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/provider/auth_pro.dart';
import 'package:classchronicalapp/utils/pick_image.dart';
import 'package:classchronicalapp/widgets/custom_simple_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditStudentProfileScreen extends StatefulWidget {
  const EditStudentProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditStudentProfileScreen> createState() =>
      _EditStudentProfileScreenState();
}

class _EditStudentProfileScreenState extends State<EditStudentProfileScreen> {
  @override
  void initState() {
    final PostProvider = Provider.of<AuthPro>(context, listen: false);
    selectedImage = PostProvider.getProfileImage;
    nameC.text = PostProvider.getFirstName;
    surnameC.text = PostProvider.getLastName;
    phoneNoC.text = PostProvider.getPhoneNo;
    cnicBformC.text = PostProvider.getCnicBform;

    super.initState();
  }

  String? selectedImage;
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

  final _formKey = GlobalKey<FormState>();
////personal details
  final TextEditingController nameC = TextEditingController();
  final TextEditingController surnameC = TextEditingController();
  final TextEditingController phoneNoC = TextEditingController();
  final TextEditingController cnicBformC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthPro>(context);
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
          onTap: () {
            if (_formKey.currentState!.validate()) {
              final authProvider = Provider.of<AuthPro>(context, listen: false);
              authProvider.studentDetailsUpdateFunc(
                  authModel.getUserUid,
                  profileImage,
                  nameC.text,
                  surnameC.text,
                  phoneNoC.text,
                  cnicBformC.text,
                  context);
            }
          },
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      profileImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: MemoryImage(profileImage!),
                            )
                          : selectedImage != ""
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(selectedImage!),
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
                            pickProfileImageFunc();
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
                  height: 20,
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
                  height: 20,
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
                  height: 20,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
