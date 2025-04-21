import 'package:cloud_firestore/cloud_firestore.dart';

class Alert {
  String alertType;
  String cameraId;
  int detectedValue;
  String locationName;
  String status;
  //final String action;
  //final String timestamp;
  String documentId;

  Alert({
    required this.alertType,
    required this.cameraId,
    required this.detectedValue,
    required this.locationName,
    required this.status,
    //required this.action,
    // required this.timestamp,
    required this.documentId,
  });

  factory Alert.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Alert(
      alertType: data['alert_type'] ?? '',
      cameraId: data['camera_id'] ?? '',
      detectedValue: data['detected_value'] ?? 0,
      locationName: data['location_name'] ?? '',
      status: data['status'] ?? '',
      // action: data['action'] ?? '',
      //timestamp: data['timestamp'] ?? '',
      documentId: document.id,
    );
  }
}
