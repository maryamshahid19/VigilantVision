import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/widgets/popup/alert_info_popup.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class CustomAlertListTile extends StatelessWidget {
  final Alert alert;
  final String volId;
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
    required this.alert,
    required this.volId,
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
          alert: alert,
          volId: volId,
          statusColor: statusColor,
        );
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
              SizedBox(height: 30),
              CustomText(
                text:
                    "By: ${alert.source == 'Admin' || alert.source.startsWith('VOL') ? alert.source : 'System'}",
                color: ClrUtils.textFourth,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
              ),
              SizedBox(height: 3),
              CustomText(
                text: "Action: ${alert.action}",
                color: ClrUtils.textFourth,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
                overflow: TextOverflow.visible,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: CustomText(
                      text:
                          "${DateFormat('dd MMMM,  hh:mm:ss a').format(alert.timestamp.toDate())}",
                      color: ClrUtils.icon,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
