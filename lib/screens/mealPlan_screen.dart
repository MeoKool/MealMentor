import 'package:flutter/material.dart';
import 'package:mealmentor/screens/ingredientScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'nutrition_screen.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({Key? key}) : super(key: key);

  @override
  _MealPlanScreenState createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  int selectedDayIndex = 0;
  List<Map<String, dynamic>> weekMealData = [];
  String token = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });
    fetchMealPlanData();
  }

  Future<void> fetchMealPlanData() async {
    const String apiUrl = 'https://meal-mentor.uydev.id.vn/api/PlanDate';

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        List<Map<String, dynamic>> meals =
            List<Map<String, dynamic>>.from(responseData['data'].map((dayData) {
          return {
            'day': DateFormat('EEE')
                .format(DateTime.parse(dayData['planDate']))
                .toUpperCase(),
            'date': DateFormat('d').format(DateTime.parse(dayData['planDate'])),
            'meals': List<Map<String, dynamic>>.from(
                dayData['details'].map((detail) {
              final meal = detail['meal'][0];
              return {
                'timeOfDay':
                    detail['type'] == 'morning' ? 'Buổi sáng' : detail['type'],
                'title': meal['name'],
                'likes': '${meal['likeQuantity']} thích món ăn này',
                'image': 'assets/images/recipe1.png',
              };
            })),
          };
        }));

        // Generate the current week's dates
        DateTime now = DateTime.now();
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        weekMealData = List.generate(7, (index) {
          DateTime day = startOfWeek.add(Duration(days: index));
          String dayName = DateFormat('EEE').format(day).toUpperCase();
          String dayDate = DateFormat('d').format(day);

          // Find meal data for the current day if available
          Map<String, dynamic>? dayData = meals.firstWhere(
            (meal) => meal['day'] == dayName && meal['date'] == dayDate,
            orElse: () => {'day': dayName, 'date': dayDate, 'meals': []},
          );

          return {
            'day': dayName,
            'date': dayDate,
            'meals': dayData['meals'], // Will be empty if no data is found
          };
        });

        setState(() {
          isLoading = false;
        });
      } else {
        print('Failed to load data');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB5D6A0),
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
        color: Color(0xFFB5D6A0),
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
                    backgroundColor: Color(0xFF374A37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Dinh dưỡng trong ngày',
                    style: TextStyle(color: Colors.white),
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
                    backgroundColor: Color(0xFF374A37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Nguyên liệu',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
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
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : weekMealData[selectedDayIndex]['meals'].isEmpty
                      ? Center(
                          child: Text(
                            'Không có dữ liệu',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView(
                          children: weekMealData[selectedDayIndex]['meals']
                              .map<Widget>((meal) {
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
                color: Color(0xFF374A37),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Xem thêm',
                style: TextStyle(
                  color: Color(0xFF374A37),
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
