import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/models/alert.dart';
import 'package:vigilant_vision/models/user.dart';
import 'package:vigilant_vision/widgets/appBar/customAppBar.dart';
import 'package:vigilant_vision/widgets/listTile/customListTile.dart';
import 'package:vigilant_vision/repositories/alert_repository.dart';

class AlertsScreen extends StatefulWidget {
  AlertsScreen({
    super.key,
    required this.volId,
    required this.user,
    required this.onProfileTap,
  });

  final String volId;
  final VoidCallback onProfileTap;
  late UserModel user;

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String selectedFilter = 'All';
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
        title: 'Alerts',
        user: widget.user,
        onProfileTap: widget.onProfileTap,
      ),
      backgroundColor: ClrUtils.primary,
      body: Center(
        child: Container(
          width: SizeCons.getWidth(context) * 0.9,
          height: MediaQuery.of(context).size.height * 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: selectedFilter,
                dropdownColor: ClrUtils.primary,
                items: <String>[
                  'All',
                  'Pending',
                  'Admin',
                  'Volunteer',
                  'Crowd',
                  'Smoke',
                  'Mask',
                  'Queue',
                  'LocationA',
                  'LocationB',
                ].map((filter) {
                  return DropdownMenuItem(
                    value: filter,
                    child: Text(filter,
                        style: TextStyle(color: ClrUtils.textFifth)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value!;
                  });
                },
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refreshAlerts,
                  child: FutureBuilder<List<Alert>>(
                      future: AlertRepository().fetchAllAlerts(),
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
                          return const Center(child: Text('No alerts found.'));
                        }

                        List<Alert> alerts = snapshot.data!;

                        if (selectedFilter != 'All') {
                          alerts = alerts.where((alert) {
                            return alert.alertType == selectedFilter ||
                                alert.status == selectedFilter.toLowerCase() ||
                                alert.source == selectedFilter ||
                                (selectedFilter == 'Volunteer' &&
                                    alert.source.startsWith('VOL')) ||
                                alert.locationName == selectedFilter;
                          }).toList();
                        }

                        return ListView.builder(
                          itemCount: alerts.length,
                          itemBuilder: (context, index) {
                            final alert = alerts[index];

                            return CustomAlertListTile(
                              alert: alert,
                              volId: widget.volId,
                              statusColor: alert.status == 'pending'
                                  ? const Color.fromARGB(255, 240, 212, 2)
                                  : (alert.status == 'assigned'
                                      ? ClrUtils.tertiary
                                      : const Color.fromARGB(255, 22, 225, 29)),
                              onPressed: () {},
                            );
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
