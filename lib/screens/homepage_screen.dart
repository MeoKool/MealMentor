import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/profile_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9DC08B), // Màu nền xanh nhạt
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            // Lời chào và logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "🌞 Chào bạn,",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Hello World",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/logoApp.png', // Logo của bạn
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Phần "Công thức mới hôm nay"
            const Text(
              "Công thức mới hôm nay",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 180, // Chiều cao của danh sách công thức
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildRecipeCard(
                    "Mì hải sản chay",
                    "James Spader",
                    "20 Min",
                    'assets/images/recipe1.png',
                  ),
                  const SizedBox(width: 10),
                  _buildRecipeCard(
                    "Bún chay",
                    "Olivia Ryan",
                    "20 Min",
                    'assets/images/recipe2.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Phần "Thực đơn hôm nay"
            const Text(
              "Thực đơn hôm nay",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                MealButton(label: "Sáng"),
                MealButton(label: "Trưa"),
                MealButton(label: "Chiều"),
                MealButton(label: "Tối"),
              ],
            ),
            const SizedBox(height: 30),
            // Phần "Món ăn phổ biến"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Món ăn phổ biến",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Tất cả",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildPopularMealCard(
                  "Salad Taco chay",
                  "120 Kcal",
                  "20 Min",
                  'assets/images/recipe1.png',
                ),
                _buildPopularMealCard(
                  "Bánh Pancake Nhật chay",
                  "64 Kcal",
                  "12 Min",
                  'assets/images/recipe2.png',
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: const Color(0xFF609966), // Màu của FAB
      //   child: const Icon(Icons.restaurant_menu),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 8.0,
      //   child: Container(
      //     height: 60,
      //     decoration: const BoxDecoration(
      //       color: Color(0xFF609966), // Màu của BottomBar
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(20),
      //         topRight: Radius.circular(20),
      //       ),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: <Widget>[
      //         IconButton(
      //           icon: const Icon(Icons.home),
      //           color: Colors.black,
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(builder: (context) => const HomePage()),
      //             );
      //           },
      //         ),
      //         IconButton(
      //           icon: const Icon(Icons.search),
      //           color: Colors.black,
      //           onPressed: () {},
      //         ),
      //         const SizedBox(width: 48), // Khoảng trống cho FAB ở giữa
      //         IconButton(
      //           icon: const Icon(Icons.notifications),
      //           color: Colors.black,
      //           onPressed: () {},
      //         ),
      //         IconButton(
      //           icon: const Icon(Icons.settings),
      //           color: Colors.black,
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => const ProfileScreen()),
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  // Hàm tạo thẻ món ăn phổ biến
  Widget _buildPopularMealCard(
      String title, String calories, String time, String imagePath) {
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
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, size: 16),
                    const SizedBox(width: 5),
                    Text(calories),
                    const Spacer(),
                    const Icon(Icons.schedule, size: 16),
                    const SizedBox(width: 5),
                    Text(time),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo thẻ công thức
  Widget _buildRecipeCard(
      String title, String chef, String time, String imagePath) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
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
              height: 80,
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
                Text(chef),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 16),
                    const SizedBox(width: 5),
                    Text(time),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Hàm tạo nút thực đơn
class MealButton extends StatelessWidget {
  final String label;
  const MealButton({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
