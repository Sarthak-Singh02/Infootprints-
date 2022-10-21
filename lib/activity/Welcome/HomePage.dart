import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infootprints_ebook/activity/Welcome/BookInfoScreen.dart';
import 'package:infootprints_ebook/activity/Welcome/SelectedGenere.dart';
import 'package:infootprints_ebook/activity/Welcome/Settings.dart';
import 'package:infootprints_ebook/activity/general/EnterLoginDetailsScreen.dart';
import 'package:infootprints_ebook/activity/utils/SharedPrefrence.dart';
import 'package:infootprints_ebook/main.dart';

import '../utils/CONFIG.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> model = [];
  String genere_1 = "";
  String genere_2 = "";
  String genere_3 = "";
  String value = "";
  GetData() async {
    var collection = FirebaseFirestore.instance.collection('user_details');
    var docName = await collection
        .doc(await SharePreference.getStringValue(CONFIG.PHONE_NUMBER))
        .get();
    if (docName.exists) {
      Map<String, dynamic>? data = docName.data();
      value = data?['name'];
      loadUser();
    }
  }

  loadUser() async {
    var collection = FirebaseFirestore.instance.collection('user_details');
    var docSnapshot = await collection
        .doc(await SharePreference.getStringValue(CONFIG.PHONE_NUMBER))
        .get();
    Map<String, dynamic>? data = docSnapshot.data();
    genere_1 = data?['generes'][0];
    genere_2 = data?['generes'][1];
    genere_3 = data?['generes'][2];
    pref_1(genere_1);
    pref_2(genere_2);
    pref_3(genere_3);
  }

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

  pref_1(String collectionValue) async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection(collectionValue).get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((DOC) {
      model.add(DOC.data());
    });
  }

  pref_2(String collectionValue) async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection(collectionValue).get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((DOC) {
      model.add(DOC.data());
    });
  }

  pref_3(String collectionValue) async {
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
    super.initState();
    GetData();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter E-book App",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: (model.isNotEmpty)
          ? ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "  Hi $value !  ",
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Based on your choices...",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemGrey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: CarouselSlider(
                  options: CarouselOptions(
                    disableCenter: true,
                    aspectRatio: 1,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 1,
                    autoPlay: true,
                  ),
                  items: model
                      .map((item) => Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        BookInfoScreen(
                                      desc: item["Description"],
                                      pdf: item["PdfUrl"],
                                      image: item["ImageUrl"],
                                      title: item["Title"],
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                item["ImageUrl"].toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                            color: Colors.white,
                          ))
                      .toList(),
                )),
                SizedBox(
                  height: 30,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Discover more...",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.systemGrey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          crossAxisCount: 2),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: BeveledRectangleBorder(
                              side: BorderSide(
                                  width: 1,
                                  strokeAlign: StrokeAlign.outside,
                                  color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 5,
                          color: CupertinoColors.systemGrey6,
                          child: InkWell(
                            splashColor: Palette.kToDark,
                            customBorder: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onTap: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      SelectedGenere(
                                    genere: reportList[index],
                                  ),
                                ),
                              );
                            },
                            child: Center(
                                child: Text(
                              reportList[index],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.kToDark),
                            )),
                          ),
                        );
                      }),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      drawer: Drawer(
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 40,
              child: FlutterLogo(
                style: FlutterLogoStyle.stacked,
                size: 80,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                value,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.systemGrey),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.systemGrey),
              ),
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "Exit App",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.systemGrey),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.arrow_right),
              title: Text(
                "Sign out",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.systemGrey),
              ),
              onTap: () async {
                Navigator.popUntil(context, (route) => route.isFirst);
                Future<void> _signOut() async {
                  await FirebaseAuth.instance.signOut();
                }

                await SharePreference.clearSharePrefrence();
                Navigator.pushReplacement<void, void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const EnterLoginDetails(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
