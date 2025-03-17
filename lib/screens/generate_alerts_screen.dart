import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/data/alerts_data.dart';
import 'package:vigilant_vision/widgets/appBar/customAppBar.dart';
import 'package:vigilant_vision/widgets/button/customButton.dart';
import 'package:vigilant_vision/widgets/listTile/customAssignedAlertTile.dart';
import 'package:vigilant_vision/widgets/popup/alert_generation_popup.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class GenerateAlertsScreen extends StatefulWidget {
  const GenerateAlertsScreen({super.key});

  @override
  State<GenerateAlertsScreen> createState() => _GenerateAlertsScreenState();
}

class _GenerateAlertsScreenState extends State<GenerateAlertsScreen> {
  void showGenerateAlertPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertGenerationPopup(
          title: "Generate Alert",
          buttonText: "Generate",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Generate Alerts"),
      backgroundColor: ClrUtils.primary,
      body: Center(
        child: Container(
          width: SizeCons.getWidth(context) * 0.9,
          height: SizeCons.getHeight(context),
          color: ClrUtils.primary,
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DottedBorder(
                color: ClrUtils.secondary,
                strokeWidth: 2,
                dashPattern: [6, 3],
                borderType: BorderType.RRect,
                radius: Radius.circular(20),
                child: CustomButton(
                  text: "+ Generate Alert",
                  onPressed: () {
                    showGenerateAlertPopup(context);
                  },
                  borderRadius: 20,
                  color: ClrUtils.secondary.withOpacity(0.2),
                  height: SizeCons.getHeight(context) * 0.2,
                  textColor: ClrUtils.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              CustomText(
                text: "Generated Alerts",
                fontWeight: FontWeight.w800,
                fontSize: 20,
                letterSpacing: 0.5,
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
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
                        buttonText: "Edit",
                        onPressed: () {},
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
