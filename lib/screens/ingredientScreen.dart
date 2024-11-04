import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({Key? key}) : super(key: key);

  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  Map<String, List<String>> ingredients = {}; // Store ingredients by day
  bool isLoading = true; // Loading state
  String token = '';

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });
    fetchIngredients();
  }

  Future<void> fetchIngredients() async {
    final response = await http.get(
        Uri.parse(
            'https://meal-mentor.uydev.id.vn/api/PlanDate/WeekIngredients'),
        headers: {
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['isSuccess']) {
        setState(() {
          // Convert each day's list to a List<String> safely
          ingredients =
              (data['data'] as Map<String, dynamic>).map((key, value) {
            return MapEntry(key, List<String>.from(value ?? []));
          });
          isLoading = false;
        });
      }
    } else {
      print('Failed to load ingredients');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Nguyên liệu tuần này'),
          centerTitle: true,
          backgroundColor: const Color(0xFFB5D6A0),
        ),
        body: Container(
          color: const Color(0xFFB5D6A0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ingredients.isEmpty
                  ? const Center(child: Text('No ingredients available'))
                  : ListView(
                      children: ingredients.entries.map((entry) {
                        return ExpansionTile(
                          title: Text(
                              getIngredientsName(entry.key)), // Day of the week
                          children: entry.value.map((ingredient) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                              child: Card(
                                child: ListTile(
                                  title: Text(ingredient, style: const TextStyle(fontSize: 18)),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ),
        ));
  }
}

String getIngredientsName(String ingredients) {
  switch (ingredients) {
    case 'monday':
      return 'Thứ hai';
    case 'tuesday':
      return 'Thứ ba';
    case 'wednesday':
      return 'Thứ tư';
    case 'thursday':
      return 'Thứ năm';
    case 'friday':
      return 'Thứ sáu';
    case 'saturday':
      return 'Thứ bảy';
    case 'sunday':
      return 'Chủ nhật';
    default:
      return 'Unknown';
  }
}
