import 'package:flutter/material.dart';

class MealPlanScreen extends StatelessWidget {
  const MealPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB5D6A0), // light green
        elevation: 0,
        title: SizedBox(),
      ),
      body: Container(
        color: Color(0xFFB5D6A0), // Background color
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF374A37), // dark green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Tạo mới thực đơn',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF374A37), // dark green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Nguyên liệu',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Date selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildDateButton('SUN', '1', false),
                buildDateButton('MON', '2', false),
                buildDateButton('TUE', '3', false),
                buildDateButton('WED', '4', true),
              ],
            ),
            SizedBox(height: 16),
            // Nutrition summary button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF374A37), // dark green
              ),
              child: Text(
                'Dinh dưỡng trong ngày',
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
            SizedBox(height: 16),
            // Meal cards
            Expanded(
              child: ListView(
                children: [
                  buildMealCard(
                      'Buổi sáng',
                      'Go to office',
                      'meeting with client singapore',
                      '1100 thích món ăn này',
                      'images/recipe1.png'),
                  buildMealCard('Buổi trưa', 'Project app bapaarekraf', '',
                      '1100 thích món ăn này', 'images/recipe1.png'),
                  buildMealCard('Buổi chiều', 'Project app bapaarekraf', '',
                      '1100 thích món ăn này', 'images/recipe1.png'),
                  buildMealCard('Buổi tối', 'Project app bapaarekraf', '',
                      '1100 thích món ăn này', 'images/recipe1.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateButton(String day, String date, bool isSelected) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF374A37) : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }

  Widget buildMealCard(String timeOfDay, String title, String subtitle,
      String likes, String imagePath) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading:
            Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.cover),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subtitle.isNotEmpty) Text(subtitle),
            Text(likes),
          ],
        ),
        trailing: Icon(Icons.edit),
      ),
    );
  }
}
