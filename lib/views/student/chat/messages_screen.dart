import 'package:classchronicalapp/color.dart';
import 'package:classchronicalapp/model/dummy_models.dart';
import 'package:classchronicalapp/routes.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        title: const Text("Chat's"),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 120),
        itemCount: messagesmodel.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              PhysicalModel(
                color: themewhitecolor,
                elevation: 5,
                borderRadius: BorderRadius.circular(12.0),
                child: ListTile(
                  onTap: () {
                    RouteNavigator.route(
                      context,
                      ChatScreen(
                        username: messagesmodel[index].title,
                        userImage: messagesmodel[index].userImage,
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      messagesmodel[index].userImage,
                    ),
                  ),
                  title: Text(
                    messagesmodel[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    messagesmodel[index].subtitle,
                  ),
                  trailing: CircleAvatar(
                    radius: 12,
                    backgroundColor: Palette.themecolor,
                    child: Text(
                      messagesmodel[index].messagescount,
                      style: TextStyle(
                        color: themewhitecolor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Divider(),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10,
          );
        },
      ),
    );
  }
}
