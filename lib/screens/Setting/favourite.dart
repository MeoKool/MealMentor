import 'package:flutter/material.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite", style: TextStyle(color: Colors.grey)),
        backgroundColor: Color(0xFF9dc08b),
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        color: Color(0xFF9dc08b), // Light green background color
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Yêu thích',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  FoodItem(iconData: Icons.cake, label: "Cupcake"),
                  FoodItem(iconData: Icons.fastfood, label: "Burger"),
                  FoodItem(iconData: Icons.local_pizza, label: "Pizza"),
                  FoodItem(iconData: Icons.cookie, label: "Cookie"),
                  FoodItem(iconData: Icons.fastfood, label: "Hot Dog"),
                  FoodItem(iconData: Icons.cookie, label: "Cookie"),
                  FoodItem(iconData: Icons.cake, label: "Cupcake"),
                  FoodItem(iconData: Icons.fastfood, label: "Burger"),
                  FoodItem(
                    iconData: Icons.add,
                    label: "Add",
                    backgroundColor: Colors.green[200],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class FoodItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color? backgroundColor;

  FoodItem({required this.iconData, required this.label, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
