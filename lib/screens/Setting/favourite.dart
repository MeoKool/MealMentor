import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Món ăn bạn đã thích", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFF9dc08b),
        elevation: 0,
        centerTitle: false,
      ),
      // Cập nhật màu nền của Scaffold thành màu 0xFF9dc08b
      body: Container(
        color: Color(0xFF9dc08b), // Light green background color
        child: FutureBuilder<List<Recipe>>(
          future: fetchLikedRecipes(), // Gọi hàm lấy dữ liệu từ API
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // Hiển thị danh sách món ăn yêu thích
              List<Recipe> recipes = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: recipes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return FoodItem(
                      label: recipes[index].name,
                      imageUrl: recipes[index].image, // Truyền ảnh món ăn
                    );
                  },
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

// Hàm lấy dữ liệu từ API và xử lý JSON
Future<List<Recipe>> fetchLikedRecipes() async {
  // Lấy token từ SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token == null) {
    throw Exception("No token found");
  }

  final response = await http.get(
    Uri.parse('https://meal-mentor.uydev.id.vn/api/Account/me'),
    headers: {
      'Authorization': 'Bearer $token', // Sử dụng token trong header
    },
  );

  if (response.statusCode == 200) {
    // Nếu yêu cầu thành công, phân tích dữ liệu JSON
    var jsonResponse = json.decode(response.body);
    var likedRecipesJson = jsonResponse['data']['likedRecipes'];

    // Chuyển dữ liệu JSON thành danh sách các đối tượng Recipe
    List<Recipe> likedRecipes = [];
    for (var recipe in likedRecipesJson) {
      likedRecipes.add(Recipe.fromJson(recipe));
    }
    return likedRecipes;
  } else {
    throw Exception('Failed to load recipes');
  }
}

// Đối tượng đại diện cho món ăn
class Recipe {
  final String name;
  final String image;

  Recipe({required this.name, required this.image});

  // Hàm chuyển dữ liệu JSON thành đối tượng Recipe
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['translatedName'] ?? json['name'], // Lấy tên đã dịch nếu có
      image: json['image'] ?? '', // Lấy hình ảnh
    );
  }
}

// Widget hiển thị thông tin món ăn
class FoodItem extends StatelessWidget {
  final String label;
  final String imageUrl;

  FoodItem({required this.label, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hiển thị hình ảnh món ăn
          Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/recipe1.png', // Đường dẫn đến hình ảnh mặc định
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              );
            },
          ),
          SizedBox(height: 5),
          // Hiển thị tên món ăn
          Text(
            label,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
