import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infootprints_ebook/activity/utils/BottomNavBar.dart';
import 'package:infootprints_ebook/activity/utils/CONFIG.dart';
import 'package:infootprints_ebook/activity/utils/SharedPrefrence.dart';
import 'package:infootprints_ebook/main.dart';

import '../Welcome/HomePage.dart';

class SelectGeneres extends StatefulWidget {
  final String user_phone;
  final String user_name;
  const SelectGeneres(
      {super.key, required this.user_phone, required this.user_name});

  @override
  State<SelectGeneres> createState() => _SelectGeneresState();
}

class _SelectGeneresState extends State<SelectGeneres> {
  List<String> reportList = [
    "Action & Fantasy",
    "Science Fiction",
    "True Crime",
    "Adventure",
    "Historical Fiction",
    "Horror",
    "Thriller & Suspense",
    "Romance",
    "Self-Help",
    "Mystery",
  ];
  List<String> selectedReportList = [];
  registerUser(List generes) async {
    final _fireStore = FirebaseFirestore.instance;
    await _fireStore.collection("user_details").doc(widget.user_phone).set({
      'name': widget.user_name,
      'phone': widget.user_phone,
      'generes': generes,
    });
    await SharePreference.setStringValue(
        CONFIG.PHONE_NUMBER, widget.user_phone);
    await SharePreference.setBooleanValue(CONFIG.IS_LOGIN, true);
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => BottomNavBar(),
      ),
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
              "  Tell us what you're into  ",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "  Choose your three favourites  ",
              style: TextStyle(
                  fontSize: 25,
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiSelectChip(
              reportList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },
              maxSelection: 3,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: selectedReportList.length >= 3 ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            registerUser(selectedReportList);
          },
          child: Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>)? onSelectionChanged;
  final Function(List<String>)? onMaxSelected;
  final int? maxSelection;

  MultiSelectChip(this.reportList,
      {this.onSelectionChanged, this.onMaxSelected, this.maxSelection});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          selectedColor: Palette.kToDark,
          label: Text(item),
          labelStyle: TextStyle(
              color:
                  selectedChoices.contains(item) ? Colors.white : Colors.black),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            if (selectedChoices.length == (widget.maxSelection ?? -1) &&
                !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
