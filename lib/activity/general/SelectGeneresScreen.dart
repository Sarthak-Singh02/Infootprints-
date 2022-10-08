import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infootprints_ebook/main.dart';

class SelectGeneres extends StatefulWidget {
  const SelectGeneres({super.key});

  @override
  State<SelectGeneres> createState() => _SelectGeneresState();
}

class _SelectGeneresState extends State<SelectGeneres> {
  List<String> reportList = [
    "Action & Adventure",
    "Science Fiction",
    "True Crime",
    "Fantasy",
    "Dystopian",
    "Historical Fiction",
    "Horror",
    "Thriller & Suspense",
    "Romance",
    "Self-Help",
    "Mystery",
    "Humor",
    "Travel",
    "Biography",
    "Auto-Biography",
    "Art & Photography",
    "Food & Drink"
  ];
  List<String> selectedReportList = [];
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
              "  Choose three or more favourites  ",
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
              maxSelection: reportList.length,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: selectedReportList.length >= 3 ? true : false,
        child: FloatingActionButton(
          onPressed: () {
           
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
