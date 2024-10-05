import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'navigation_menu.dart'; // Import your NavigationMenu

class NutritionScreen extends StatelessWidget {
  // User intake values for each meal (morning, noon, afternoon)
  final Map<String, Map<String, double>> userIntake = {
    'morning': {'protein': 20, 'calories': 300, 'fat': 10, 'carbs': 50},
    'noon': {'protein': 25, 'calories': 600, 'fat': 20, 'carbs': 70},
    'afternoon': {'protein': 15, 'calories': 200, 'fat': 8, 'carbs': 30},
  };

  // Standard intake values for each meal (morning, noon, afternoon)
  final Map<String, Map<String, double>> standardIntake = {
    'morning': {'protein': 25, 'calories': 350, 'fat': 12, 'carbs': 55},
    'noon': {'protein': 30, 'calories': 650, 'fat': 25, 'carbs': 75},
    'afternoon': {'protein': 20, 'calories': 250, 'fat': 10, 'carbs': 40},
  };

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi', null);
    String todayDate = DateFormat('EEEE, d MMMM, yyyy', 'vi').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFB5D6A0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB5D6A0),
        title: Text(
          todayDate,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFB5D6A0),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildMealCard(context, 'Buổi sáng', 'morning'),
              _buildMealCard(context, 'Buổi trưa', 'noon'),
              _buildMealCard(context, 'Buổi chiều', 'afternoon'),
            ],
          ),
        ),
      ),
      // You will not use the bottom navigation bar here; it'll be handled by NavigationMenu.
    );
  }

  Widget _buildMealCard(BuildContext context, String mealName, String mealKey) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mealName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildNutrientComparison('Protein', userIntake[mealKey]!['protein']!, standardIntake[mealKey]!['protein']!),
            _buildNutrientComparison('Calories', userIntake[mealKey]!['calories']!, standardIntake[mealKey]!['calories']!),
            _buildNutrientComparison('Fat', userIntake[mealKey]!['fat']!, standardIntake[mealKey]!['fat']!),
            _buildNutrientComparison('Carbs', userIntake[mealKey]!['carbs']!, standardIntake[mealKey]!['carbs']!),
          ],
        ),
      ),
    );
  }

Widget _buildNutrientComparison(String nutrient, double userValue, double standardValue) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        nutrient,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 6),
      Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), // Add border radius
                color: Colors.grey[300], // Background color for the progress
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners for the progress
                child: LinearProgressIndicator(
                  value: userValue / standardValue,
                  backgroundColor: Colors.transparent, // Make background transparent
                  color: userValue > standardValue ? Colors.red : Colors.green,
                  minHeight: 10,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Display userValue and standardValue with a '/' in between
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners for the highlight
            ),
            child: Row(
              children: [
                // User value
                Text(
                  '${userValue.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4), // Small space between values
                const Text(
                  '/', // The slash between the two values
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF374A37),
                  ),
                ),
                const SizedBox(width: 4), // Small space before the standard value
                // Standard value with a larger font size and bold
                Text(
                  '$standardValue',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Larger font size for standard value
                    color: Color(0xFF374A37),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
    ],
  );
}

}
