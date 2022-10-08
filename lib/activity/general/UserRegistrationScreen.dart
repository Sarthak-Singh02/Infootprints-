import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infootprints_ebook/activity/general/SelectGeneresScreen.dart';
import 'package:infootprints_ebook/main.dart';

class UserRegistrtaionScreen extends StatefulWidget {
  const UserRegistrtaionScreen({super.key});

  @override
  State<UserRegistrtaionScreen> createState() => _UserRegistrtaionScreenState();
}

class _UserRegistrtaionScreenState extends State<UserRegistrtaionScreen> {
  TextEditingController nameController = TextEditingController();
  Widget creatAccount(
      TextEditingController controller, String hintText, Widget prefixIcon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
          controller: controller,
          onChanged: (value) {
            setState(() {});
          },
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                width: 2.0,
                color: Palette.kToDark,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: CupertinoColors.systemGrey,
                width: 2.0,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 60,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              " What is your name ? ",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          creatAccount(nameController, "Name", Icon(CupertinoIcons.person)),
          SizedBox(
            height: 20,
          ),
          Visibility(
            visible: (nameController.text.isNotEmpty) ? true : false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushReplacement<void, void>(
                    context,
                    CupertinoPageRoute<void>(
                      builder: (BuildContext context) => SelectGeneres(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
