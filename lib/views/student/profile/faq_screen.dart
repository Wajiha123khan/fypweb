import 'package:classchronicalapp/color.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
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
        title: const Text("FAQ's"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        primary: false,
        shrinkWrap: true,
        itemCount: faqmodel.length,
        itemBuilder: (context, index) {
          return PhysicalModel(
            color: themewhitecolor,
            elevation: 10,
            borderRadius: BorderRadius.circular(15),
            child: ExpansionTile(
              collapsedTextColor: themeblackcolor,
              collapsedIconColor: themeblackcolor,
              childrenPadding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
              title: Text(
                faqmodel[index].title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: const [
                Divider(color: themedarkgreycolor),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                  style: TextStyle(
                    color: themeblackcolor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}

class FaqModel {
  final String title;

  FaqModel({
    required this.title,
  });
}

List<FaqModel> faqmodel = [
  FaqModel(
    title: "What is Chronical App",
  ),
  FaqModel(
    title: "How to use Chronical App",
  ),
  FaqModel(
    title: "Benefits of Chronical App",
  ),
  FaqModel(
    title: "What is Chronical App",
  ),
];
