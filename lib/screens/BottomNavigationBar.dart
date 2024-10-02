import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color(0xFF609966), // Màu nền của BottomBar
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: currentIndex == 0 ? Colors.black : Colors.grey,
              ),
              onPressed: () => onTap(0),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: currentIndex == 1 ? Colors.black : Colors.grey,
              ),
              onPressed: () => onTap(1),
            ),
            const SizedBox(width: 48), // Khoảng trống cho FAB ở giữa
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: currentIndex == 2 ? Colors.black : Colors.grey,
              ),
              onPressed: () => onTap(2),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: currentIndex == 3 ? Colors.black : Colors.grey,
              ),
              onPressed: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBarWithFab extends StatefulWidget {
  @override
  _BottomNavBarWithFabState createState() => _BottomNavBarWithFabState();
}

class _BottomNavBarWithFabState extends State<BottomNavBarWithFab> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Page ${_currentIndex + 1}',
          style: TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFF609966), // Màu của nút FAB ở giữa
        child: const Icon(Icons.restaurant_menu),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
