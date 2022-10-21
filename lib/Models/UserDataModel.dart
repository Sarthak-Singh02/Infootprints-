// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
   String? Description;
   String? Title;
   String?  PdfUrl;
   String? ImageUrl;
  UserModel({
    this.Description,
    this.Title,
    this.PdfUrl,
    this.ImageUrl,
  });
  List<UserModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;

      return UserModel(
          Description: dataMap['Description'],
          Title: dataMap['Title'],
          PdfUrl: dataMap['PdfUrl'],
          ImageUrl: dataMap['ImageUrl']);
    }).toList();
  }
}
