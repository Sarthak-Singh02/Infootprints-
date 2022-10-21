import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infootprints_ebook/main.dart';

import '../utils/CONFIG.dart';
import '../utils/SharedPrefrence.dart';

class BookInfoScreen extends StatefulWidget {
  final String image;
  final String desc;
  final String pdf;
  final String title;
  const BookInfoScreen(
      {super.key,
      required this.image,
      required this.desc,
      required this.pdf,
      required this.title});

  @override
  State<BookInfoScreen> createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  Set _data = {};
  final _fireStore = FirebaseFirestore.instance;
  addToFavourites() async {
    await _fireStore
        .collection("user_details")
        .doc(await SharePreference.getStringValue(CONFIG.PHONE_NUMBER))
        .collection("Favourites")
        .doc(widget.title)
        .set({
      'Image': widget.image,
      'Pdf': widget.pdf,
      'Title': widget.title,
      'Description': widget.desc,
    });
  }

  deleteFromFavourites() async {
    await _fireStore
        .collection("user_details")
        .doc(await SharePreference.getStringValue(CONFIG.PHONE_NUMBER))
        .collection("Favourites")
        .doc(widget.title)
        .delete();
  }

  getAllDocs() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('user_details')
        .doc(await SharePreference.getStringValue(CONFIG.PHONE_NUMBER))
        .collection("Favourites")
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    documents.forEach((data) => (_data.addAll({data["Title"]})));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDocs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Palette.kToDark,
            ),
          ),
          backgroundColor: CupertinoColors.systemGrey6,
          iconTheme: IconThemeData(color: Palette.kToDark),
          actions: [
            IconButton(
                onPressed: () async {
                  if (_data.contains(widget.title)) {
                    deleteFromFavourites();
                  } else {
                    addToFavourites();
                  }

                  setState(() {
                    _data.clear();
                    getAllDocs();
                  });
                },
                icon: (_data.contains(widget.title))
                    ? Icon(
                        Icons.favorite,
                        color: CupertinoColors.systemRed,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: CupertinoColors.systemRed,
                      ))
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              width: 150,
              child: Image.network(
                widget.image,
                scale: 10,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  child: Text(
                    widget.desc,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
              onPressed: () {},
              child: Text(
                "Read (PDF)",
                style: TextStyle(fontSize: 22),
              )),
        ));
  }
}
