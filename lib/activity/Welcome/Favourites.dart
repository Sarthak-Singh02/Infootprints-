import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infootprints_ebook/activity/Welcome/BookInfoScreen.dart';
import 'package:infootprints_ebook/activity/utils/CONFIG.dart';
import 'package:infootprints_ebook/activity/utils/SharedPrefrence.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<dynamic> model = [];
  pref_1() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection("user_details")
        .doc(await SharePreference.getStringValue(CONFIG.PHONE_NUMBER))
        .collection("Favourites")
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((DOC) {
      model.add(DOC.data());
    });
    setState(() {});
  }

  @override
  void initState() {
    pref_1();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Favourites",
                  style: TextStyle(
                      fontSize: 25, color: CupertinoColors.systemGrey),
                )),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.length,
              itemBuilder: ((context, index) {
                final item = model[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: CupertinoColors.systemGrey4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => BookInfoScreen(
                            image: item["Image"],
                            pdf: item["Pdf"],
                            title: item["Title"],
                            desc: item["Description"],
                          ),
                        ),
                      ).then((_) => setState(() {
                            model.clear();
                            pref_1();
                          }));
                    },
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        item["Image"],
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Text(
                      item["Title"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.systemGrey),
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
