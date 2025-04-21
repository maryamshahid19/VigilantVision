import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';
import 'package:vigilant_vision/widgets/button/customButton.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class ConfirmationPopup extends StatelessWidget {
  Alert alert;
  // final String title;
  // final String alertClass;
  // final int peopleDetected;
  // final String action;
  final String text1;
  final String text2;
  final String text3;

  ConfirmationPopup({
    super.key,
    required this.alert,
    // required this.title,
    // required this.alertClass,
    // required this.peopleDetected,
    // required this.action,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ClrUtils.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: ClrUtils.icon, width: 3),
      ),
      child: Container(
        width: SizeCons.getWidth(context) * 0.9,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: text1,
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 0.3,
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: "Volunteering ${alert.locationName}",
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 0.3,
              color: Colors.black,
            ),
            SizedBox(height: 5),
            RichText(
              text: TextSpan(
                text: "Alert class : ",
                style: TextStyle(
                  color: ClrUtils.textFourth,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
                children: [
                  TextSpan(
                    text: alert.alertType,
                    style: TextStyle(
                      color: ClrUtils.textTertiary,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomText(
              text: "People Detected: ${alert.detectedValue}",
              color: ClrUtils.textFourth,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
            SizedBox(height: 5),
            CustomText(
              text: "Action: take an action",
              color: ClrUtils.textFourth,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CustomButton(
                        text: text2,
                        color: ClrUtils.primary,
                        textColor: ClrUtils.secondary,
                        borderColor: ClrUtils.secondary,
                        onPressed: () {
                          Navigator.pop(context);
                        })),
                SizedBox(width: 5),
                Expanded(
                    child: CustomButton(
                        text: text3,
                        onPressed: () {
                          if (text3 == 'Confirm') {
                            AlertRepository().updateAlertStatus(
                                alert.documentId, "assigned");
                          } else {
                            AlertRepository().updateAlertStatus(
                                alert.documentId, "resolved");
                          }
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
