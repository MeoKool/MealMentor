import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecipeDetailPageHome extends StatefulWidget {
  final int recipeId;

  const RecipeDetailPageHome({Key? key, required this.recipeId})
      : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPageHome> {
  Map<String, dynamic>? recipe;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchRecipeDetails();
  }

  // Fetch recipe details based on recipeId
  Future<void> fetchRecipeDetails() async {
    final String apiUrl =
        'https://meal-mentor.uydev.id.vn/api/Recipe/${widget.recipeId}';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          recipe = data['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print("Exception caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF609966),
      appBar: AppBar(
        backgroundColor: const Color(0xFF609966),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Chi tiết món ăn",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text("Failed to load recipe details"))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hình ảnh món ăn
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/recipe1.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Tên món ăn và lượt thích
                        Center(
                          child: Column(
                            children: [
                              Text(
                                recipe?['name'] ?? "No name",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${recipe?['likeQuantity'] ?? 0} thích món ăn này",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Phần chi tiết món ăn
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Công thức:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF40513B),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ..._buildIngredients(recipe?['ingredients']),
                              const SizedBox(height: 20),
                              const Text(
                                "Cách nấu:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF40513B),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                recipe?['instruction'] ??
                                    "No instructions available",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  List<Widget> _buildIngredients(List<dynamic>? ingredients) {
    if (ingredients == null || ingredients.isEmpty) {
      return [const Text("No ingredients available")];
    }
    return ingredients.map((ingredient) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.black),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              ingredient,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
          ),
        ],
      );
    }).toList();
  }
}
