import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/data/alerts_data.dart';
import 'package:vigilant_vision/widgets/appBar/customAppBar.dart';
import 'package:vigilant_vision/widgets/listTile/customListTile.dart';

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
      body: Center(
        child: Container(
          width: SizeCons.getWidth(context) * 0.9,
          child: ListView.builder(
            itemCount: AlertsData.alerts.length,
            itemBuilder: (context, index) {
              final alert = AlertsData.alerts[index];
              if (alert["status"] == "Resolved") {
                return SizedBox.shrink();
              }
              return CustomAlertListTile(
                title: alert["title"],
                alertClass: alert["alertClass"],
                peopleDetected: alert["peopleDetected"],
                action: alert["action"],
                status: alert["status"],
                statusColor: alert["statusColor"],
                onPressed: () {},
                // width: SizeCons.getWidth(context) * 0.8,
              );
            },
            // },
          ),
        ),
      ),
    );
  }
}
