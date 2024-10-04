import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/profile_screen.dart';
import 'package:mealmentor/screens/homepage_screen.dart';
import 'package:mealmentor/screens/mealPlan_screen.dart';
import 'package:mealmentor/screens/search_screen.dart';
import 'package:mealmentor/screens/notification_screen.dart';
import 'package:mealmentor/screens/setting_screen.dart';

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
      // Custom floating action button in the center
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 2; // Setting the middle item as selected
          });
        },
        backgroundColor: const Color(0xFF609966),
        child: const Icon(
          Icons.restaurant_menu, // Replace with your chef hat icon
          size: 30,
          color: Color(0xFF40513B),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFF609966),
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   topRight: Radius.circular(20),
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Home Button
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: _selectedIndex == 0
                      ? Color(0xFF40513B)
                      : const Color.fromARGB(102, 64, 81, 59),
                  size: 30,
                ),
                onPressed: () {
                  _onItemTapped(0);
                },
              ),
              // Search Button
              IconButton(
                icon: Icon(Icons.search,
                    color: _selectedIndex == 1
                        ? Color(0xFF40513B)
                        : const Color.fromARGB(102, 64, 81, 59),
                    size: 30),
                onPressed: () {
                  _onItemTapped(1);
                },
              ),
              // Spacer for the floating button
              const SizedBox(width: 50),
              // Notification Button
              IconButton(
                icon: Icon(Icons.notifications,
                    color: _selectedIndex == 3
                        ? Color(0xFF40513B)
                        : const Color.fromARGB(102, 64, 81, 59),
                    size: 30),
                onPressed: () {
                  _onItemTapped(3);
                },
              ),
              // Settings Button
              IconButton(
                icon: Icon(Icons.settings,
                    color: _selectedIndex == 4
                        ? Color(0xFF40513B)
                        : const Color.fromARGB(102, 64, 81, 59),
                    size: 30),
                onPressed: () {
                  _onItemTapped(4);
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _getSelectedPage(_selectedIndex),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
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
