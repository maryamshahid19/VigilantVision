// import 'package:firebase_auth/firebase_auth.dart';

// class AuthRepository {
//   final FirebaseAuth _firebaseAuth;

//   AuthRepository({FirebaseAuth? firebaseAuth})
//       : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

//   Future<User?> signUp({required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   Future<User?> logIn({required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   Future<void> logOut() async {
//     await _firebaseAuth.signOut();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigilant_vision/models/user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> signUp(
      {required String email,
      required String password,
      required String fullName,
      required String phoneNo}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // added user other details in firestore because required to maintain profile and in app data
      User? user = userCredential.user;

      if (user != null) {
        final snapshot =
            await FirebaseFirestore.instance.collection('user').get();

        final newVolID =
            'VOL${(snapshot.docs.length + 1).toString().padLeft(3, '0')}';

        await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
          'phoneNo': phoneNo,
          'volID': newVolID,
        });
      }

      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> logIn({required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();

    // Remove login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<UserModel> getCurrentUser() async {
    User? user = _firebaseAuth.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(user?.uid)
        .get();

    final userDetails = UserModel.fromSnapshot(snapshot);
  
    return userDetails;
  }
}
