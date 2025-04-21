import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';
import 'package:vigilant_vision/widgets/button/customButton.dart';
import 'package:vigilant_vision/widgets/popup/confirmation_popup.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class AlertInfoPopup extends StatelessWidget {
  Alert alert;
  // final String title;
  // final String alertClass;
  // final int peopleDetected;
  // final String action;
  // String status;
  final Color statusColor;

  AlertInfoPopup({
    super.key,
    required this.alert,
    // required this.title,
    // required this.alertClass,
    // required this.peopleDetected,
    // required this.action,
    // required this.status,
    required this.statusColor,
  });

  void showConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationPopup(
            text1: "Are you sure?",
            alert: alert,
            // title: alert.locationName,
            // alertClass: alert.alertType,
            // peopleDetected: alert.detectedValue,
            // action: "take an action",
            text2: "Cancel",
            text3: "Confirm");
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
      // child: Container(
      //   width: SizeCons.getWidth(context) * 0.9,
      //   height: 260,
      //   padding: EdgeInsets.all(20),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       //  Row(
      //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       //   children: [
      //       //    Column(
      //       //      crossAxisAlignment: CrossAxisAlignment.start,
      //       //     children: [

      //       Container(
      //         height: 40,
      //         width: 150,
      //         decoration: BoxDecoration(
      //           color: statusColor.withOpacity(0.1),
      //           border: Border.all(color: statusColor, width: 1),
      //           borderRadius: BorderRadius.circular(20),
      //         ),
      //         child: Center(
      //           child: CustomText(
      //             text: status,
      //             fontWeight: FontWeight.w500,
      //             color: statusColor,
      //           ),
      //         ),
      //       ),
      //       SizedBox(height: 15),
      //       CustomText(
      //         text: title,
      //         fontWeight: FontWeight.w800,
      //         fontSize: 16,
      //         letterSpacing: 0.3,
      //         color: Colors.black,
      //       ),
      //       SizedBox(height: 3),
      //       RichText(
      //         text: TextSpan(
      //           text: "Alert class : ",
      //           style: TextStyle(
      //             color: ClrUtils.textFourth,
      //             fontWeight: FontWeight.w400,
      //             letterSpacing: 0.3,
      //           ),
      //           children: [
      //             TextSpan(
      //               text: alertClass,
      //               style: TextStyle(
      //                 color: ClrUtils.textTertiary,
      //                 fontWeight: FontWeight.w400,
      //                 letterSpacing: 0.3,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       //   ],
      //       //  ),
      //       // Container(
      //       //   height: 30,
      //       //   width: 100,
      //       //   decoration: BoxDecoration(
      //       //     color: statusColor.withOpacity(0.1),
      //       //     border: Border.all(color: statusColor, width: 1),
      //       //     borderRadius: BorderRadius.circular(20),
      //       //   ),
      //       //   child: Center(
      //       //     child: CustomText(
      //       //       text: status,
      //       //       fontWeight: FontWeight.w500,
      //       //       color: statusColor,
      //       //     ),
      //       //   ),
      //       // ),
      //       //     ],
      //       //    ),
      //       SizedBox(height: 20),
      //       CustomText(
      //         text: "People Detected: $peopleDetected",
      //         color: ClrUtils.textFourth,
      //         fontWeight: FontWeight.w400,
      //         letterSpacing: 0.3,
      //       ),
      //       CustomText(
      //         text: "Action: $action",
      //         color: ClrUtils.textFourth,
      //         fontWeight: FontWeight.w400,
      //         letterSpacing: 0.3,
      //       ),
      //       SizedBox(height: 15),
      //       if (status == "Pending")
      //         CustomButton(text: "Volunteer", onPressed: () {}),
      //     ],
      //   ),
      // ),

      child: Container(
        width: SizeCons.getWidth(context) * 0.9,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: alert.locationName,
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
                  ],
                ),
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    border: Border.all(color: statusColor, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: CustomText(
                      text: alert.status,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomText(
              text: "People Detected: $alert.detectedValue",
              color: ClrUtils.textFourth,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
            CustomText(
              text: "Action: Take and action",
              color: ClrUtils.textFourth,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
            ),
            SizedBox(height: 15),
            if (alert.status == "pending")
              CustomButton(
                  text: "Volunteer",
                  onPressed: () async {
                    showConfirmationPopup(context);

                    //setState() {
                    //  alert.status = "assigned";
                    // }
                  }),
          ],
        ),
      ),
    );
  }
}
