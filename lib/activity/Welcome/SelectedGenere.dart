// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:infootprints_ebook/Models/UserDataModel.dart';
import 'package:infootprints_ebook/activity/utils/CONFIG.dart';
import 'package:infootprints_ebook/activity/utils/SharedPrefrence.dart';
import 'package:infootprints_ebook/main.dart';

import 'BookInfoScreen.dart';

class SelectedGenere extends StatefulWidget {
  const SelectedGenere({
    Key? key,
    required this.genere,
  }) : super(key: key);
  final String genere;
  @override
  State<SelectedGenere> createState() => _SelectedGenereState();
}

class _SelectedGenereState extends State<SelectedGenere> {
  List<dynamic> model = [];
  pref_1(String collectionValue) async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection(collectionValue).get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((DOC) {
      model.add(DOC.data());
    });
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    pref_1(widget.genere);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.genere,
          style: TextStyle(color: Palette.kToDark, fontWeight: FontWeight.bold),
        ),
        backgroundColor: CupertinoColors.systemGrey6,
        iconTheme: IconThemeData(color: Palette.kToDark),
      ),
      body: GridView.builder(
          itemCount: model.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 5 / 7),
          itemBuilder: ((context, index) {
            final item = model[index];
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  side: BorderSide(
                      strokeAlign: StrokeAlign.outside, color: Colors.grey)),
              color: CupertinoColors.systemGrey6,
              child: InkWell(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => BookInfoScreen(
                        desc: item["Description"],
                        pdf: item["PdfUrl"],
                        image: item["ImageUrl"],
                        title: item["Title"],
                      ),
                    ),
                  );
                },
                child: GridTile(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Image.network(
                      item["ImageUrl"],
                      fit: BoxFit.fill,
                    ),
                  ),
                  footer: Center(
                      child: Text(
                    item["Title"],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemGrey,
                        fontSize: 15),
                  )),
                ),
              ),
            );
          })),
    );
  }
}
