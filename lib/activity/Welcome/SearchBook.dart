import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infootprints_ebook/Models/UserDataModel.dart';
import 'package:infootprints_ebook/main.dart';

class SearchBook extends StatefulWidget {
  const SearchBook({super.key});

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FirestoreSearchScaffold(
      firestoreCollectionName: 'Science Fiction',
      searchBy: 'Title',
      scaffoldBody: Center(),
      dataListFromSnapshot: UserModel().dataListFromSnapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<UserModel>? dataList = snapshot.data;
          if (dataList!.isEmpty) {
            return const Center(
              child: Text('No Results Found'),
            );
          }
          return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final UserModel data = dataList[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(data.ImageUrl.toString()),
                    title: Text(
                      '${data.Title}',
                    ),
                  ),
                );
              });
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Results Returned'),
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
