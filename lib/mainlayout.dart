import 'package:flutter/material.dart';
import 'package:vigilant_vision/screens/alerts_screen.dart';
import 'package:vigilant_vision/screens/assigned_alerts_screen.dart';
import 'package:vigilant_vision/screens/generate_alerts_screen.dart';
import 'package:vigilant_vision/screens/profile_screen.dart';
import 'package:vigilant_vision/widgets/navBar/customNavBar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    AlertsScreen(),
    GenerateAlertsScreen(),
    AssignedAlertsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
