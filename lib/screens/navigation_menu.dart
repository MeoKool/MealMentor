import 'package:flutter/material.dart';
import 'package:mealmentor/screens/homepage_screen.dart';
import 'package:mealmentor/screens/profile_screen.dart';
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
      backgroundColor: Colors.white,
      // Custom floating action button in the center
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 2; // Setting the middle item as selected
          });
        },
        backgroundColor: Color(0xFF609966),
        child: Icon(
          Icons.restaurant_menu, // Replace with your chef hat icon
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Bottom navigation bar with a notch for the floating button
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFF609966),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Home Button
              IconButton(
                icon: Icon(Icons.home,
                    color:
                        _selectedIndex == 0 ? Colors.white : Color(0xFF40513B),
                    size: 35),
                onPressed: () {
                  _onItemTapped(0);
                },
              ),
              // Search Button
              IconButton(
                icon: Icon(Icons.search,
                    color:
                        _selectedIndex == 1 ? Colors.white : Color(0xFF40513B),
                    size: 35),
                onPressed: () {
                  _onItemTapped(1);
                },
              ),
              // Spacer for the floating button
              SizedBox(width: 50),
              // Notification Button
              IconButton(
                icon: Icon(Icons.notifications,
                    color:
                        _selectedIndex == 3 ? Colors.white : Color(0xFF40513B),
                    size: 35),
                onPressed: () {
                  _onItemTapped(3);
                },
              ),
              // Settings Button
              IconButton(
                icon: Icon(Icons.settings,
                    color:
                        _selectedIndex == 4 ? Colors.white : Color(0xFF40513B),
                    size: 35),
                onPressed: () {
                  _onItemTapped(4);
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: _getSelectedPage(_selectedIndex), // Display the selected page
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
        return HomePage(); // Home Page
      case 1:
        return SearchScreen(); // Search Page
      case 2:
        return NotificationScreen(); // Center Button Page
      case 3:
        return NotificationScreen(); // Notification Page
      case 4:
        return ProfileScreen(); // Settings Page
      default:
        return HomePage(); // Default to Home Page
    }
  }
}
