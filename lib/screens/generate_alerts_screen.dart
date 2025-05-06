import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/models/user.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';
import 'package:vigilant_vision/widgets/appBar/customAppBar.dart';
import 'package:vigilant_vision/widgets/button/customButton.dart';
import 'package:vigilant_vision/widgets/listTile/customAssignedAlertTile.dart';
import 'package:vigilant_vision/widgets/popup/alert_generation_popup.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class GenerateAlertsScreen extends StatefulWidget {
  GenerateAlertsScreen(
      {super.key,
      required this.volId,
      required this.user,
      required this.onProfileTap});

  final String volId;
  late UserModel user;
  final VoidCallback onProfileTap;

  @override
  State<GenerateAlertsScreen> createState() => _GenerateAlertsScreenState();
}

class _GenerateAlertsScreenState extends State<GenerateAlertsScreen> {
  late Future<List<Alert>> _alertsFuture;

  Future<void> _refreshAlerts() async {
    setState(() {
      _alertsFuture = AlertRepository().fetchAllAlerts();
    });
  }

  void showGenerateAlertPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertGenerationPopup(
          title: "Generate Alert",
          buttonText: "Generate",
          volId: widget.volId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Generate Alerts",
        user: widget.user,
        onProfileTap: widget.onProfileTap,
      ),
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
                  child: RefreshIndicator(
                    onRefresh: _refreshAlerts,
                    child: FutureBuilder<List<Alert>>(
                      future:
                          AlertRepository().fetchGeneratedAlerts(widget.volId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('No alerts generated yet.'));
                        }

                        List<Alert> alerts = snapshot.data!;

                        return ListView.builder(
                          itemCount: alerts.length,
                          itemBuilder: (context, index) {
                            final alert = alerts[index];

                            return CustomAssignedAlertTile(
                              alert: alert,
                              volId: widget.volId,
                              statusColor: alert.status == 'pending'
                                  ? const Color.fromARGB(255, 240, 212, 2)
                                  : (alert.status == 'assigned'
                                      ? ClrUtils.tertiary
                                      : const Color.fromARGB(255, 22, 225, 29)),
                              buttonText: "Edit",
                              onPressed: () {},
                            );
                          },
                        );
                      },
                    ),
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
