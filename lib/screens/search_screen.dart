import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
            // Phần ảnh nền và biểu tượng avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/backgroundSearch.jpg'), // Thay bằng hình ảnh của bạn
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            // Phần thanh tìm kiếm
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: 'Tất cả',
                    icon: const Icon(Icons.arrow_drop_down),
                    underline: Container(),
                    onChanged: (String? newValue) {},
                    items: <String>['Tất cả', 'Chay', 'Mặn']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Phần danh sách món ăn
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
                children: [
                  _buildRecipeCard(
                      'Hamburger chay', 'Rs. 1234', 'assets/images/recipe1.png'),
                  _buildRecipeCard(
                      'Pizza chay', 'Rs. 1234', 'assets/images/recipe2.png'),
                  _buildRecipeCard(
                      'Salad chay', 'Rs. 1234', 'assets/images/recipe1.png'),
                  _buildRecipeCard(
                      'Burger chay', 'Rs. 1234', 'assets/images/recipe1.png'),
                  _buildRecipeCard(
                      'Sandwich chay', 'Rs. 1234', 'assets/images/recipe1.png'),
                  _buildRecipeCard(
                      'Salad rau', 'Rs. 1234', 'assets/images/recipe2.png'),
                ],
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
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
