import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vigilant_vision/models/alert.dart';

class AlertRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<Alert>> fetchAllAlerts() async {
    final snapshot = await _db.collection('alerts').get();
    final alertData =
        snapshot.docs.map((doc) => Alert.fromSnapshot(doc)).toList();

    return alertData;
  }

  Future<List<Alert>> fetchAssignedAlerts() async {
    final snapshot = await _db.collection('alerts').get();
    final alertData = snapshot.docs
        .map((doc) => Alert.fromSnapshot(doc))
        .where((alert) => alert.status != 'pending')
        .toList();

    return alertData;
  }

  Future<void> updateAlertStatus(String documentId, String newStatus) async {
    await _db.collection('alerts').doc(documentId).update({
      'status': newStatus,
    });
  }
}
