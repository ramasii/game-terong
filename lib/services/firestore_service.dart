import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // collection name
  static String usrAccountsCollection = 'user_accounts';

  Future<void> addUser(String username, String pass) async {
    try {
      await _firestore.collection(usrAccountsCollection).doc(username).set({
        'username': username,
        'password': pass,
        'date_created': FieldValue.serverTimestamp(),
        'date_edited': FieldValue.serverTimestamp(),
      });
      print('User added successfully');
    } catch (e) {
      log('Error adding user: $e');
    }
  }

  Future<bool> isUsernameExisted(String username) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(usrAccountsCollection)
          .where("username", isEqualTo: username)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          print('User found: ${doc.data() as Map}');
        });

        return false;
      } else {
        print('No user found with username: $username');

        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
