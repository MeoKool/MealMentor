import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMealPlanScreen extends StatefulWidget {
  const AddMealPlanScreen({super.key});

  @override
  _AddMealPlanScreenState createState() => _AddMealPlanScreenState();
}

class _AddMealPlanScreenState extends State<AddMealPlanScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedType = 'morning';
  List<Map<String, dynamic>> recipes = [];
  List<int> selectedRecipeIds = [];
  bool isLoading = true;
  String token = '';

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? '';
    });

    const String apiUrl =
        'https://meal-mentor.uydev.id.vn/api/Recipe/get-all?PageSize=99';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          recipes =
              List<Map<String, dynamic>>.from(responseData['data']['items']);
          isLoading = false;
        });
      } else {
        print("Failed to load recipes");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addMealPlan() async {
    if (selectedRecipeIds.isEmpty) {
      Fluttertoast.showToast(
        msg: "Vui lòng chọn ít nhất 1 món ăn!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    const String apiUrl = 'https://meal-mentor.uydev.id.vn/api/PlanDate';
    final body = {
      "description": "Meal Plan Description", // Customize as needed
      "planDate": selectedDate.toIso8601String(),
      "details": [
        {"meals": selectedRecipeIds, "type": selectedType}
      ]
    };

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          },
          body: json.encode(body));

      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "Tạo thực đơn mới thành công!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context, true);
      } else {
        Fluttertoast.showToast(
          msg: "Tạo thực đơn lỗi, vui lòng thử lại!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFB5D6A0),
          title: Text("Thêm thực đơn"),
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xFFB5D6A0),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Icon(Icons.calendar_today),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null && picked != selectedDate)
                            setState(() {
                              selectedDate = picked;
                            });
                        },
                      ),

                      // Dropdown for Meal Type
                      DropdownButton<String>(
                        value: selectedType,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedType = newValue!;
                          });
                        },
                        items: <String>['morning', 'noon', 'night']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value == 'morning'
                                    ? 'Buổi sáng'
                                    : value == 'noon'
                                        ? 'Buổi trưa'
                                        : 'Buổi tối',
                              ));
                        }).toList(),
                      ),

                      // Multi-Select for Recipes
                      Expanded(
                        child: ListView(
                          children: recipes.map((recipe) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  recipe['image'] != null &&
                                          recipe['image'] != ''
                                      ? Image.network(
                                          recipe['image'],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            // Display a fallback image or any other widget you prefer when an error occurs
                                            return Image.asset(
                                              'assets/images/recipe1.png', // fallback image
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          'assets/images/recipe1.png',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          recipe['translatedName'] ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          recipe['description'] ?? '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          "${recipe['likeQuantity'] ?? 0} yêu thích",
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Checkbox(
                                    value: selectedRecipeIds
                                        .contains(recipe['id']),
                                    onChanged: (bool? selected) {
                                      setState(() {
                                        if (selected!) {
                                          selectedRecipeIds.add(recipe['id']);
                                        } else {
                                          selectedRecipeIds
                                              .remove(recipe['id']);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Submit Button
                      ElevatedButton(
                        onPressed: addMealPlan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF374A37),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          "Thêm thực đơn",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
