import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/widgets/popup/alert_info_popup.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class CustomAlertListTile extends StatelessWidget {
  final String title;
  final String alertClass;
  final int peopleDetected;
  final String action;
  final String status;
  final Color statusColor;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final double fontSize;
  final double height;
  final double width;
  final FontWeight? fontWeight;
  final Color borderColor;
  final double borderWidth;

  const CustomAlertListTile({
    super.key,
    required this.title,
    required this.alertClass,
    required this.peopleDetected,
    required this.action,
    required this.status,
    required this.statusColor,
    required this.onPressed,
    this.color = ClrUtils.secondary,
    this.textColor = ClrUtils.textPrimary,
    this.borderRadius = 10.0,
    this.elevation = 0,
    this.fontSize = 14.0,
    this.height = 48,
    this.width = double.infinity,
    this.fontWeight = FontWeight.normal,
    this.borderColor = ClrUtils.border,
    this.borderWidth = 1,
  });

  void showAlertInfoPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertInfoPopup(
            title: title,
            alertClass: alertClass,
            peopleDetected: peopleDetected,
            action: action,
            status: status,
            statusColor: statusColor);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        decoration: BoxDecoration(
          color: ClrUtils.background,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: ClrUtils.border, width: 1),
        ),
        child: ListTile(
          onTap: onPressed,
          minTileHeight: 150,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
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
                              text: alertClass,
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
                        text: status,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              CustomText(
                text: "People Detected: $peopleDetected",
                color: ClrUtils.textFourth,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CustomText(
                      text: "Action: $action",
                      color: ClrUtils.textFourth,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ClrUtils.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          ),
                        ]),
                    child: IconButton(
                      onPressed: () {
                        showAlertInfoPopup(context);
                      },
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      iconSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
