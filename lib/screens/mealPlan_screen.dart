import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/pickpackage_screen.dart';
import 'package:mealmentor/screens/addMealPlanScreen.dart';
import 'package:mealmentor/screens/detailsRecipePage.dart';
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
  bool subcribe = false;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      subcribe = prefs.getBool('subcribe') ?? false;
    });
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });

    fetchMealPlanData();
  }

  Future<void> fetchMealPlanData() async {
    setState(() {
      isLoading = true;
    });
    const String apiUrl = 'https://meal-mentor.uydev.id.vn/api/PlanDate';

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Map to group meals by date (ignoring time)
        Map<String, Map<String, List<Map<String, dynamic>>>> mealsByDate = {};

        for (var dayData in responseData['data']) {
          // Extract only the date part (yyyy-MM-dd)
          String dateKey = DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(dayData['planDate']));

          // Initialize the structure for the day if not already present
          mealsByDate.putIfAbsent(dateKey,
              () => {"Buổi sáng": [], "Buổi trưa": [], "Buổi tối": []});

          for (var detail in dayData['details']) {
            // Determine the time of day
            String timeOfDay = detail['type'] == 'morning'
                ? 'Buổi sáng'
                : detail['type'] == 'noon'
                    ? 'Buổi trưa'
                    : 'Buổi tối';

            // Only proceed if the 'meal' list is not empty
            if (detail['meal'] is List && (detail['meal'] as List).isNotEmpty) {
              // Safely add meals to the timeOfDay list
              mealsByDate[dateKey]![timeOfDay]!.addAll(
                (detail['meal'] as List).map<Map<String, dynamic>>((meal) {
                  return {
                    'id': meal['id'] ?? 0,
                    'title': meal['name'] ?? 'No Title',
                    'likes': '${meal['likeQuantity'] ?? 0} thích món ăn này',
                    'image': meal['image'] ?? 'assets/images/recipe1.png',
                  };
                }).toList(),
              );
            }
          }
        }

        // Generate the current week's dates and populate `weekMealData` based on `mealsByDate`
        DateTime now = DateTime.now();
        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        weekMealData = List.generate(7, (index) {
          DateTime day = startOfWeek.add(Duration(days: index));
          String dayName = DateFormat('EEE').format(day).toUpperCase();
          String dayDate = DateFormat('d').format(day);
          String dateKey = DateFormat('yyyy-MM-dd').format(day);

          // Find meals for the current day if available, otherwise set empty meals
          Map<String, dynamic>? dayData = mealsByDate[dateKey] ??
              {"Buổi sáng": [], "Buổi trưa": [], "Buổi tối": []};

          return {
            'day': dayName,
            'date': dayDate,
            'mealsByTime': dayData,
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
        backgroundColor: const Color(0xFFB5D6A0),
        elevation: 0,
        title: const Text(
          'Thực đơn hàng ngày',
          style: TextStyle(
            color: Color(0xFF374A37),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: const Color(0xFFB5D6A0),
        padding: const EdgeInsets.all(16.0),
        child: subcribe
            ? Column(
                children: [
                  // Buttons at the top
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
                          backgroundColor: const Color(0xFF374A37),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
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
                          backgroundColor: const Color(0xFF374A37),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Nguyên liệu',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Date selection
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(weekMealData.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddMealPlanScreen()),
                          );
                          if (result == true) {
                            fetchMealPlanData();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF374A37),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Thêm thực đơn',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : (weekMealData[selectedDayIndex]['mealsByTime']
                                    ?.values
                                    .every((mealList) =>
                                        (mealList as List).isEmpty) ??
                                true)
                            ? const Center(
                                child: Text(
                                  'Không có dữ liệu',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              )
                            : ListView(
                                children: weekMealData[selectedDayIndex]
                                        ['mealsByTime']!
                                    .entries
                                    .map<Widget>((entry) {
                                  String timeOfDay = entry.key;
                                  List<Map<String, dynamic>> meals =
                                      List<Map<String, dynamic>>.from(
                                          entry.value ?? []);
                                  if (meals.isNotEmpty) {
                                    return buildMealCard(timeOfDay, meals);
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                }).toList(),
                              ),
                  )
                ],
              )
            : buildUpgradePrompt(), // Show the upgrade prompt if not subscribed
      ),
    );
  }

  Widget buildUpgradePrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Vui lòng nâng cấp để mở khoá tính năng này",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle the upgrade action
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PickPackageScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Nâng cấp ngay",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
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
            getStringDay(day).toString(),
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

  String getStringDay(String day) {
    switch (day) {
      case 'MON':
        return 'T2';
      case 'TUE':
        return 'T3';
      case 'WED':
        return 'T4';
      case 'THU':
        return 'T5';
      case 'FRI':
        return 'T6';
      case 'SAT':
        return 'T7';
      case 'SUN':
        return 'CN';
      default:
        return 'Hai';
    }
  }

  Widget buildMealCard(String timeOfDay, List<Map<String, dynamic>> meals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'Xem thêm',
            //     style: TextStyle(
            //       color: Color(0xFF374A37),
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 8),
        ...meals.map((meal) => Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                onTap: () {
                  print(meal);
                  if (meal.containsKey('id')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailPageHome(recipeId: meal['id']),
                      ),
                    );
                  } else {
                    print("Meal ID not found");
                  }
                },
                leading: meal['image'] != null && meal['image'] != 'string'
                    ? Image.network(
                        meal['image'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/images/recipe1.png', // fallback image
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/recipe1.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                title: Text(meal['title']),
                subtitle: Text(meal['likes']),
              ),
            )),
      ],
    );
  }
}
