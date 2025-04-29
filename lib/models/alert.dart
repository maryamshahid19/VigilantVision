import 'package:cloud_firestore/cloud_firestore.dart';

class Alert {
  String alertType;
  String source;
  int detectedValue;
  String locationName;
  String status;
  String? assignedTo;
  String action;
  Timestamp timestamp;
  String documentId;

  Alert({
    required this.alertType,
    required this.source,
    required this.detectedValue,
    required this.locationName,
    required this.status,
    required this.assignedTo,
    required this.action,
    required this.timestamp,
    required this.documentId,
  });

  factory Alert.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Alert(
      alertType: data['alert_type'] ?? '',
      source: data['camera_id'] ?? '',
      detectedValue: data['detected_value'] ?? 0,
      locationName: data['location_name'] ?? '',
      status: data['status'] ?? '',
      assignedTo: data['assigned_to'] ?? '',
      action: data['action'] ?? '',
      timestamp: data['timestamp'] ?? '',
      documentId: document.id,
    );
  }
}
