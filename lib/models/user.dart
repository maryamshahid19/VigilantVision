import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String fullName;
  final String phoneNo;
  final String volID;

  UserModel(
      {required this.email,
      required this.fullName,
      required this.phoneNo,
      required this.volID});

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return UserModel(
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNo: data['phoneNo'] ?? '',
      volID: data['volID'] ?? '',
    );
  }
}
