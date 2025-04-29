import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';
import 'package:vigilant_vision/widgets/button/customButton.dart';
import 'package:vigilant_vision/widgets/popup/confirmation_popup.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class AlertInfoPopup extends StatefulWidget {
  Alert alert;
  final String volId;
  final Color statusColor;

  AlertInfoPopup({
    super.key,
    required this.alert,
    required this.volId,
    required this.statusColor,
  });

  @override
  State<AlertInfoPopup> createState() => _AlertInfoPopupState();
}

class _AlertInfoPopupState extends State<AlertInfoPopup> {
  void showConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationPopup(
          text1: "Are you sure?",
          alert: widget.alert,
          volId: widget.volId,
          text2: "Cancel",
          text3: "Confirm",
        );
      },
    );
  }

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
            SizedBox(height: 15),
            Container(
              height: 30,
              width: 100,
              decoration: BoxDecoration(
                color: widget.statusColor.withOpacity(0.1),
                border: Border.all(color: widget.statusColor, width: 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: CustomText(
                  text: widget.alert.status,
                  fontWeight: FontWeight.w500,
                  color: widget.statusColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomText(
              text: widget.alert.locationName,
              fontWeight: FontWeight.w800,
              fontSize: 16,
              letterSpacing: 0.3,
              color: Colors.black,
            ),
            SizedBox(height: 3),
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
                    text: widget.alert.alertType,
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
              text:
                  "By: ${widget.alert.source == 'Admin' || widget.alert.source.startsWith('VOL') ? widget.alert.assignedTo : 'System'}",
              color: ClrUtils.textFourth,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
            SizedBox(height: 3),
            CustomText(
              text: "People Detected: ${widget.alert.detectedValue}",
              color: ClrUtils.textFourth,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
            SizedBox(height: 10),
            CustomText(
              text: "Action: ${widget.alert.action}",
              color: ClrUtils.textFifth,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              letterSpacing: 0.3,
            ),
            SizedBox(height: 20),
            CustomText(
              text:
                  "${DateFormat('dd MMMM,  hh:mm:ss a').format(widget.alert.timestamp.toDate())}",
              color: ClrUtils.icon,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: 15),
            if (widget.alert.status == "pending")
              CustomButton(
                  text: "Volunteer",
                  onPressed: () async {
                    Navigator.of(context).pop();
                    showConfirmationPopup(context);
                  }),
          ],
        ),
      ),
    );
  }
}
