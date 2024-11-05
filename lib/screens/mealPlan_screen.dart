import 'package:flutter/material.dart';
import 'package:mealmentor/screens/ingredientScreen.dart';
import 'nutrition_screen.dart';
import 'package:intl/intl.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({Key? key}) : super(key: key);

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  // The selected index of the day
  int selectedDayIndex = 0;
  late List<Map<String, dynamic>> weekMealData;

  @override
  void initState() {
    super.initState();
    weekMealData = getCurrentWeekData(); // Initialize weekMealData in initState
  }

  // Dummy data for each day of the week
  List<Map<String, dynamic>> getCurrentWeekData() {
    List<Map<String, dynamic>> weekData = [];
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));

    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      String dayName = DateFormat('EEE').format(day).toUpperCase();
      String dayDate = day.day.toString();

      weekData.add({
        'day': dayName,
        'date': dayDate,
        'meals': [
          {
            'timeOfDay': 'Buổi sáng',
            'title': 'Breakfast',
            'likes': '${(500 - i * 50)} thích món ăn này',
            'image': 'assets/images/recipe1.png'
          },
          {
            'timeOfDay': 'Buổi trưa',
            'title': 'Lunch',
            'likes': '${(600 + i * 100)} thích món ăn này',
            'image': 'assets/images/recipe2.png'
          },
        ],
      });
    }
    return weekData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB5D6A0), // light green
        elevation: 0,
        title: Text(
          'Thực đơn hàng ngày',
          style: TextStyle(
            color: Color(0xFF374A37),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NutritionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF374A37), // dark green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Dinh dưỡng trong ngày',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngredientScreen()),
                    );
                  },
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
            // Date selector for the week
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(weekMealData.length, (index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDayIndex = index;
                          });
                        },
                        child: buildDateButton(
                          weekMealData[index]['day'],
                          weekMealData[index]['date'],
                          index == selectedDayIndex,
                        ),
                      ));
                }),
              ),
            ),
            SizedBox(height: 16),

            SizedBox(height: 16),
            // Meal cards
            Expanded(
              child: ListView(
                children:
                    weekMealData[selectedDayIndex]['meals'].map<Widget>((meal) {
                  return buildMealCard(
                    meal['timeOfDay'],
                    meal['title'],
                    '',
                    meal['likes'],
                    meal['image'],
                  );
                }).toList(),
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
      width: 70,
      height: 90,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF374A37) : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMealCard(String timeOfDay, String title, String subtitle,
      String likes, String imagePath) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              timeOfDay,
              style: TextStyle(
                color: Color(0xFF374A37), // dark green
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Xem thêm',
                style: TextStyle(
                  color: Color(0xFF374A37), // dark green
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Image.asset(imagePath,
                width: 60, height: 60, fit: BoxFit.cover),
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
        ),
      ],
    );
  }
}
