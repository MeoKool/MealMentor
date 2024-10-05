import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF609966), // Màu nền chính
      appBar: AppBar(
        backgroundColor: const Color(0xFF609966),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Điều hướng về trang trước đó
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
                  image: const DecorationImage(
                    image: AssetImage("images/recipe1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Tên món ăn và lượt thích
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Salad Taco chay",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        SizedBox(width: 5),
                        Text(
                          "1100 thích món ăn này",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
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
                      "Công thức:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF40513B),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildIngredientItem("Cà rốt 500g"),
                    _buildIngredientItem("Su hào 300g"),
                    _buildIngredientItem("Cà chua 200g"),
                    _buildIngredientItem("Đậu hũ 300g"),
                    _buildIngredientItem("Xiên que"),
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
                    const Text(
                      "• Nấu trong 30 phút\n• Chiên với dầu thực vật",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 20),

                    // Chi tiết dinh dưỡng
                    const Text(
                      "Chi tiết dinh dưỡng:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF40513B),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildNutritionDetail("Đạm", "200 g"),
                    _buildNutritionDetail("Tinh bột", "100 g"),
                    _buildNutritionDetail("Béo", "50 g"),
                    _buildNutritionDetail("Khoáng", "Sắt, Kẽm"),
                    _buildNutritionDetail("Vitamin", "A, B12, D"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Nút "Trở về"
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF40513B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 60),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Trở về trang trước đó
                  },
                  child: const Text(
                    "Trở về",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm xây dựng mỗi mục trong danh sách nguyên liệu
  Widget _buildIngredientItem(String ingredient) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 6, color: Colors.black),
        const SizedBox(width: 10),
        Text(
          ingredient,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  // Hàm xây dựng các chi tiết dinh dưỡng
  Widget _buildNutritionDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Text(
            "$label :",
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
