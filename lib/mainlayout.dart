import 'package:flutter/material.dart';
import 'package:vigilant_vision/models/user.dart';
import 'package:vigilant_vision/repositories/auth_repository.dart';
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
  late UserModel user;

  List<Widget> _screens = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    user = await AuthRepository().getCurrentUser();
    setState(() {
      _screens = [
        AlertsScreen(
          volId: user.volID,
          user: user,
          onProfileTap: goToProfile,
        ),
        GenerateAlertsScreen(
            volId: user.volID, user: user, onProfileTap: goToProfile),
        AssignedAlertsScreen(
            volId: user.volID, user: user, onProfileTap: goToProfile),
        ProfileScreen(user: user),
      ];
    });
  }

  void goToProfile() {
    setState(() {
      _selectedIndex = 3;
    });
  }

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
