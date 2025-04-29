import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/models/user.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';
import 'package:vigilant_vision/widgets/appBar/customAppBar.dart';
import 'package:vigilant_vision/widgets/listTile/customAssignedAlertTile.dart';

class AssignedAlertsScreen extends StatefulWidget {
  AssignedAlertsScreen(
      {super.key,
      required this.volId,
      required this.user,
      required this.onProfileTap});

  final String volId;
  late UserModel user;
  final VoidCallback onProfileTap;

  @override
  State<AssignedAlertsScreen> createState() => _AssignedAlertsScreenState();
}

class _AssignedAlertsScreenState extends State<AssignedAlertsScreen> {
  late Future<List<Alert>> _alertsFuture;

  Future<void> _refreshAlerts() async {
    setState(() {
      _alertsFuture = AlertRepository().fetchAllAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Assigned Tasks",
        user: widget.user,
        onProfileTap: widget.onProfileTap,
      ),
      backgroundColor: ClrUtils.primary,
      body: Center(
        child: Container(
          width: SizeCons.getWidth(context) * 0.9,
          height: SizeCons.getHeight(context),
          child: Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshAlerts,
              child: FutureBuilder(
                  future: AlertRepository().fetchAssignedAlerts(widget.volId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No alerts assigned yet.'));
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
                          buttonText: "Completed",
                          onPressed: () {},
                        );
                      },
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
