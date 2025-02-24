import 'package:flutter/material.dart';
import 'package:vigilant_vision/constants/color_constants.dart';
import 'package:vigilant_vision/constants/screensize_constants.dart';
import 'package:vigilant_vision/widgets/listTile/customListTile.dart';
import 'package:vigilant_vision/widgets/text/customText.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final List<String> alerts = [
    'Crowd at Loc A: 18 detected',
    'No-Queue formed at Loc B',
    'People not wearing masks in Zone X: 5 detected',
    'People smoking in Zone Y: 2 detected',
    'Main Hall overcrowded',
    'Crowd at Loc A: 18 detected',
    'No-Queue formed at Loc B',
    'People not wearing masks in Zone X: 5 detected',
    'People smoking in Zone Y: 2 detected',
    'Main Hall overcrowded',
    'People not wearing masks in Zone X: 5 detected',
    'People smoking in Zone Y: 2 detected',
    'Main Hall overcrowded',
    'Crowd at Loc A: 18 detected',
    'No-Queue formed at Loc B',
    'People not wearing masks in Zone X: 5 detected',
    'People smoking in Zone Y: 2 detected',
    'Main Hall overcrowded',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: '  Alerts',
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      body: Center(
        child: Container(
          width: SizeCons.getWidth(context) * 0.9,
          child: Expanded(
            child: ListView.builder(
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  return CustomListTile(text: alerts[index], onPressed: () {});
                }),
          ),
        ),
      ),
    );
  }
}
