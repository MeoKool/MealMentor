import 'package:flutter/material.dart';
import 'package:mealmentor/screens/detailsRecipe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> _recipes = [];

  Future<void> _fetchRecipes(String keyword) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      final response = await http.get(Uri.parse(
          'https://meal-mentor.uydev.id.vn/api/Recipe/get-by-name?keyword=$keyword&PageNumber=1&PageSize=99'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data']['items'] != null) {
          setState(() {
            _recipes = data['data']['items']; // Populate the _recipes list
          });
        } else {
          setState(() {
            _recipes = []; // Ensure the list is empty if no items are found
          });
        }
        Navigator.of(context).pop();
      } else {
        print('Failed to load recipes');
        setState(() {
          _recipes = []; // Handle error by emptying the list
        });
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error fetching recipes: $e');
      setState(() {
        _recipes = []; // Handle error by emptying the list
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _fetchRecipes(''); // Default search keyword
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9DC08B), // Màu nền xanh lá nhạt
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/backgroundSearch.jpg'), // Thay bằng hình ảnh của bạn
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Phần thanh tìm kiếm
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm",
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _fetchRecipes(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Phần danh sách món ăn
            Expanded(
              child: _recipes.isEmpty
                  ? Center(
                      child: Text(
                        'Không tìm thấy món ăn nào',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _recipes[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailPage(recipe: recipe),
                              ),
                            );
                          },
                          child: _buildRecipeCard(
                              recipe['translatedName'] ?? 'No name',
                              recipe['calories'] != null
                                  ? '${recipe['calories'].toStringAsFixed(2)} calories'
                                  : 'No calories',
                              recipe['image'] ??
                                  'https://png.pngtree.com/thumb_back/fw800/background/20240229/pngtree-plate-with-vegan-or-vegetarian-food-in-womans-hand-image_15633697.jpg'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm xây dựng từng thẻ công thức nấu ăn
  Widget _buildRecipeCard(String title, String price, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              imagePath,
              width: double.infinity,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                // Display a fallback image or any other widget you prefer when an error occurs
                return Image.asset(
                  'assets/images/recipe1.png', // fallback image
                  width: double.infinity,
                  height: 110,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(price, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
