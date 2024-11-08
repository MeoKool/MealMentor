import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mealmentor/screens/detailsRecipePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with AutomaticKeepAliveClientMixin {
  String username = '';
  String token = '';
  String email = '';
  String userId = '';
  List<String> recipeList = [];
  List<dynamic> recipes = [];
  List<dynamic> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    fetchUserInfo();
    await fetchRecipes();
    await fetchFavoriteRecipes();
  }

  void fetchUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      token = prefs.getString('token') ?? '';
      email = prefs.getString('email') ?? '';
      userId = prefs.getString('userId') ?? '';
      recipeList = prefs.getStringList('recipeList') ?? [];
    });
  }

  Future<void> fetchRecipes() async {
    const String apiUrl =
        'https://meal-mentor.uydev.id.vn/api/Recipe/get-all?orderBy=CreateDateTime';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          recipes = data['data']['items'];
        });
      }
    } catch (e) {
      debugPrint("Exception caught: $e");
    }
  }

  Future<void> fetchFavoriteRecipes() async {
    const String favoriteApiUrl =
        'https://meal-mentor.uydev.id.vn/api/Recipe/get-all?orderBy=LikeQuantity';
    try {
      final response = await http.get(Uri.parse(favoriteApiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          favoriteRecipes = data['data']['items'];
        });
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  Future<void> likeRecipe(int recipeId) async {
    final String likeApiUrl =
        'https://meal-mentor.uydev.id.vn/api/User/like-recipe?recipeId=$recipeId';
    try {
      final response = await http.post(
        Uri.parse(likeApiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Đã thêm món ăn yêu thích!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          recipeList.add(recipeId.toString());
        });
        fetchFavoriteRecipes();
        await Future.delayed(const Duration(seconds: 1));
        fetchRecipes();
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  Future<void> dislikeRecipe(int recipeId) async {
    final String dislikeApiUrl =
        'https://meal-mentor.uydev.id.vn/api/User/dislike-recipe?recipeId=$recipeId';
    try {
      final response = await http.post(
        Uri.parse(dislikeApiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Đã xóa món ăn khỏi danh sách yêu thích!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          recipeList.remove(recipeId.toString());
        });
        fetchFavoriteRecipes();
        await Future.delayed(const Duration(seconds: 1));
        fetchRecipes();
      } else {
        Fluttertoast.showToast(
          msg: "Không thể xóa món ăn khỏi danh sách yêu thích!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xFF9DC08B),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            _buildGreetingSection(),
            const SizedBox(height: 40),
            _buildSectionTitle("Thực đơn mới hôm nay"),
            const SizedBox(height: 10),
            _buildHorizontalRecipeList(recipes),
            const SizedBox(height: 40),
            _buildSectionTitle("Món ăn được yêu thích nhất"),
            const SizedBox(height: 10),
            _buildHorizontalRecipeList(favoriteRecipes, isFavorite: true),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "🌞 Hello,",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            Text(
              username,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/logoApp.png'),
        ),
      ],
    );
  }

  _buildHorizontalRecipeList(List<dynamic> recipeList,
      {bool isFavorite = false}) {
    return SizedBox(
      height: 300,
      child: recipeList.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recipeList.length,
              itemBuilder: (context, index) {
                final recipe = recipeList[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildRecipeCard(
                    recipe['name'] ?? 'No Name',
                    recipe['createDateTime'] ?? '',
                    recipe['calories'] ?? 0,
                    recipe['likeQuantity'] ?? '0',
                    recipe['id'],
                    imageUrl: recipe['image'],
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.green.shade900,
      ),
    );
  }

  _buildRecipeCard(String name, String createDateTime, dynamic calories,
      String likeQuantity, int recipeId,
      {String? imageUrl}) {
    bool isLiked = recipeList.contains(recipeId.toString());
    final String defaultImageUrl =
        'https://png.pngtree.com/thumb_back/fw800/background/20240229/pngtree-plate-with-vegan-or-vegetarian-food-in-womans-hand-image_15633697.jpg';
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailPageHome(recipeId: recipeId),
          ),
        );
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                    (imageUrl != null && imageUrl.isNotEmpty)
                        ? imageUrl
                        : defaultImageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Recipe name
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Creation date
            Text(
              " ${DateFormat('dd/MM/yyyy').format(DateTime.parse(createDateTime))}",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            const SizedBox(height: 8),
            // Calories display, converting to int if needed
            Row(
              children: [
                Icon(Icons.local_fire_department,
                    color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text(
                  "${calories is double ? calories.toInt() : calories} kcal",
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.thumb_up, color: Colors.blueAccent, size: 16),
                const SizedBox(width: 4),
                Text(
                  "$likeQuantity likes",
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    if (isLiked) {
                      dislikeRecipe(recipeId);
                    } else {
                      likeRecipe(recipeId);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
