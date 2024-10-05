import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/profile_screen.dart';
import 'package:mealmentor/screens/homepage_screen.dart';
import 'package:mealmentor/screens/mealPlan_screen.dart';
import 'package:mealmentor/screens/search_screen.dart';
import 'package:mealmentor/screens/notification_screen.dart';

class NavigationMenu extends StatefulWidget {
  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0; // Currently selected index, starts with Home

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF609966),
      body: Column(
        children: [
          Expanded(
            child: _getSelectedPage(_selectedIndex),
          ),
        ],
      ),
      // Your custom floating navigation bar
      bottomNavigationBar: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // Background of the navigation bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF609966), // Background color
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
            ),
            // Center button
            Positioned(
              bottom: 10, // Adjusts the button's vertical position
              left: MediaQuery.of(context).size.width / 2 - 35, // Center the button horizontally
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 2; // Set the middle item as selected
                  });
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFF609966),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.restaurant_menu, // Replace with your desired icon
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // Left icons
            Positioned(
              bottom: 20,
              left: 30,
              child: GestureDetector(
                onTap: () {
                  _onItemTapped(0);
                },
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: _selectedIndex == 0 ? Colors.white : Colors.white54,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 110,
              child: GestureDetector(
                onTap: () {
                  _onItemTapped(1);
                },
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: _selectedIndex == 1 ? Colors.white : Colors.white54,
                ),
              ),
            ),
            // Right icons
            Positioned(
              bottom: 20,
              right: 110,
              child: GestureDetector(
                onTap: () {
                  _onItemTapped(3);
                },
                child: Icon(
                  Icons.notifications,
                  size: 30,
                  color: _selectedIndex == 3 ? Colors.white : Colors.white54,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 30,
              child: GestureDetector(
                onTap: () {
                  _onItemTapped(4);
                },
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: _selectedIndex == 4 ? Colors.white : Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return const HomePage(); // Home Page
      case 1:
        return const SearchScreen(); // Search Page
      case 2:
        return const MealPlanScreen(); // Center Button Page
      case 3:
        return const NotificationScreen(); // Notification Page
      case 4:
        return const ProfileScreen(); // Settings Page
      default:
        return const HomePage(); // Default to Home Page
    }
  }
}
