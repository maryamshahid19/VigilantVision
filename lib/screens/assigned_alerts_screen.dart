import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/data/alerts_data.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';
import 'package:vigilant_vision/widgets/appBar/customAppBar.dart';
import 'package:vigilant_vision/widgets/listTile/customAssignedAlertTile.dart';

class AssignedAlertsScreen extends StatefulWidget {
  const AssignedAlertsScreen({super.key});

  @override
  State<AssignedAlertsScreen> createState() => _AssignedAlertsScreenState();
}

class _AssignedAlertsScreenState extends State<AssignedAlertsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Assigned Tasks"),
      backgroundColor: ClrUtils.primary,
      // body: Center(
      //   child: Container(
      //     width: SizeCons.getWidth(context) * 0.9,
      //     height: SizeCons.getHeight(context),
      //     child: FutureBuilder(
      //         future: AlertRepository().fetchAssignedAlerts(),
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return const Center(child: CircularProgressIndicator());
      //           }

      //           if (snapshot.hasError) {
      //             return Center(child: Text("Error: ${snapshot.error}"));
      //           }

      //           if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //             return const Center(child: Text('No alerts found.'));
      //           }

      //           List<Alert> alerts = snapshot.data!;
      //           // if (alerts.status == '');

      //           return ListView.builder(
      //             itemCount: alerts.length,
      //             itemBuilder: (context, index) {
      //               final alert = alerts[index];

      //               if (alerts.isNotEmpty) {
      //                 return CustomAssignedAlertTile(
      //                   alert: alert,
      //                   // title: alert.locationName,
      //                   // alertClass: alert.alertType,
      //                   // peopleDetected: alert.detectedValue,
      //                   // action: "take the action",
      //                   // status: alert.status,
      //                   statusColor: alert.status == 'pending'
      //                       ? Colors.yellow
      //                       : (alert.status == 'assigned'
      //                           ? Colors.blue
      //                           : Colors.green),
      //                   buttonText: "Completed",
      //                   onPressed: () {},
      //                 );
      //               } else {
      //                 return Text("No Alerts Assigned yet");
      //               }
      //             },
      //           );
      //         }),
      //   ),
      // ),
    );
  }
}
