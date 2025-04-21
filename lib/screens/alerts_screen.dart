import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/data/alerts_data.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/widgets/appBar/customAppBar.dart';
import 'package:vigilant_vision/widgets/listTile/customListTile.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Alerts'),
      backgroundColor: ClrUtils.primary,
      // body: Center(
      //   child: Container(
      //     width: SizeCons.getWidth(context) * 0.9,
      //     child: FutureBuilder<List<Alert>>(
      //         future: AlertRepository().fetchAllAlerts(),
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
      //           return ListView.builder(
      //             itemCount: alerts.length,
      //             itemBuilder: (context, index) {
      //               final alert = alerts[index];
      //               print(alert.alertType);
      //               if (alert.status == "Resolved") {
      //                 return SizedBox.shrink();
      //               }
      //               return CustomAlertListTile(
      //                 alert: alert,
      //                 // title: alert.locationName,
      //                 // alertClass: alert.alertType,
      //                 // peopleDetected: alert.detectedValue,
      //                 // action: "take the action",
      //                 // status: alert.status,
      //                 statusColor: alert.status == 'pending'
      //                     ? Colors.yellow
      //                     : (alert.status == 'assigned'
      //                         ? Colors.blue
      //                         : Colors.green),
      //                 onPressed: () {},
      //                 // width: SizeCons.getWidth(context) * 0.8,
      //               );
      //             },
      //             //  },
      //           );
      //           // }
      //           //   }
      //         }),
      //   ),
      // ),
    );
  }
}
