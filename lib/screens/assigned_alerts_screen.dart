import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/data/alerts_data.dart';
import 'package:vigilant_vision/widgets/appBar/customAppBar.dart';
import 'package:vigilant_vision/widgets/listTile/customAssignedAlertTile.dart';

class AssignedAlertsScreen extends StatelessWidget {
  const AssignedAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Assigned Tasks"),
      backgroundColor: ClrUtils.primary,
      body: Center(
        child: Container(
          width: SizeCons.getWidth(context) * 0.9,
          height: SizeCons.getHeight(context),
          child: ListView.builder(
            itemCount: AlertsData.alerts.length,
            itemBuilder: (context, index) {
              final alert = AlertsData.alerts[index];

              return CustomAssignedAlertTile(
                title: alert["title"],
                alertClass: alert["alertClass"],
                peopleDetected: alert["peopleDetected"],
                action: alert["action"],
                status: alert["status"],
                statusColor: alert["statusColor"],
                buttonText: "Completed",
                onPressed: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
