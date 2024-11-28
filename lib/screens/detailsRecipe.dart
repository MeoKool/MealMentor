import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

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
      body: SingleChildScrollView(
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
                  image: DecorationImage(
                    image: recipe['image'] != null && recipe['image'].isNotEmpty
                        ? NetworkImage(recipe['image'])
                        : AssetImage(
                            "assets/images/recipe1.png"), // Use recipe image if available
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
                      recipe['translatedName'] ?? "No name",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${recipe['likeQuantity'] ?? '0'} thích món ăn này", // Replace with actual data if available
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
                    // Công thức
                    const Text(
                      "Nguyên liệu:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF40513B),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._buildIngredients(recipe['ingredients']),
                    const SizedBox(height: 20),

                    // Cách nấu
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
                      recipe['instruction'] ?? "Chưa có cách nấu",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
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

  // Build ingredients list
  List<Widget> _buildIngredients(List<dynamic> ingredients) {
    return ingredients.map((ingredient) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.black),
          const SizedBox(width: 10),
          // Flexible widget ensures the text wraps within the available space
          Flexible(
            child: Text(
              ingredient,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.clip, // Prevent overflow and wrap text
              softWrap: true,
            ),
          ),
        ],
      );
    }).toList();
  }
}
