import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infootprints_ebook/activity/Welcome/Favourites.dart';
import 'package:infootprints_ebook/activity/Welcome/HomePage.dart';
import 'package:infootprints_ebook/activity/Welcome/SearchBook.dart';

import '../../main.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = [];
  @override
  void initState() {
    super.initState();
    if (mounted)
      setState(() {
        pages = [
          SearchBook(
            
          ),
          HomePage(
            
          ),
          Favourites(),

        ];
      });
  }

  int currentIndex = 1;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
  bottomNavigationBar: ConvexAppBar(
        shadowColor: Palette.kToDark,
        activeColor: Palette.kToDark,
        backgroundColor: CupertinoColors.systemGrey6,
        color: Palette.kToDark,
        style: TabStyle.textIn,
        items: [
          TabItem(icon: Icons.search, title: "Search"),
          TabItem(icon: Icons.home_filled, title: "Home"),
          TabItem(icon: Icons.favorite, title: "Favourites"),
        ],
        initialActiveIndex: currentIndex,
        onTap: (int i) => setState(() {
          currentIndex = i;
        }),
      ),
    );
    
  }
}