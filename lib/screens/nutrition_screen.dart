import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class NutritionScreen extends StatelessWidget {
  final Map<String, Map<String, double>> userIntake = {
    'morning': {'protein': 20, 'calories': 300, 'fat': 10, 'carbs': 50},
    'noon': {'protein': 25, 'calories': 600, 'fat': 20, 'carbs': 70},
    'afternoon': {'protein': 15, 'calories': 200, 'fat': 8, 'carbs': 30},
  };

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
                borderRadius: BorderRadius.circular(8.0), 
                color: Colors.grey[300], 
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0), 
                child: LinearProgressIndicator(
                  value: userValue / standardValue,
                  backgroundColor: Colors.transparent, 
                  color: userValue > standardValue ? Colors.red : Colors.green,
                  minHeight: 10,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), 
            ),
            child: Row(
              children: [
                Text(
                  '${userValue.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '/', 
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF374A37),
                  ),
                ),
                const SizedBox(width: 4), 
                Text(
                  '$standardValue',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, 
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
