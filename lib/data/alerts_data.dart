import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';

class AlertsData {
  static final List<Map<String, dynamic>> alerts = [
    {
      "title": "Alert at building 2",
      "alertClass": "Crowd",
      "peopleDetected": 10,
      "action": "Guide attendees to location B",
      "status": "Pending",
      "statusColor": Colors.red,
    },
    {
      "title": "Main Hall Overcrowded",
      "alertClass": "Crowd",
      "peopleDetected": 30,
      "action": "Direct people to alternative locations",
      "status": "Assigned",
      "statusColor": ClrUtils.tertiary,
    },
    {
      "title": "Alert at building 5",
      "alertClass": "No Mask",
      "peopleDetected": 5,
      "action": "Notify security to enforce mask rule",
      "status": "Resolved",
      "statusColor": Colors.green,
    },
    {
      "title": "Alert at Zone A",
      "alertClass": "Smoking",
      "peopleDetected": 2,
      "action": "Issue warning to individuals",
      "status": "Pending",
      "statusColor": Colors.red,
    },
    {
      "title": "Main Hall Overcrowded",
      "alertClass": "Crowd",
      "peopleDetected": 30,
      "action": "Direct people to alternative locations",
      "status": "Assigned",
      "statusColor": ClrUtils.tertiary,
    },
    {
      "title": "Alert at building 2",
      "alertClass": "Crowd",
      "peopleDetected": 10,
      "action": "Guide attendees to location B",
      "status": "Pending",
      "statusColor": Colors.red,
    },
  ];
}
