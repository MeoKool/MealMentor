import 'package:flutter/material.dart';
import 'package:mealmentor/screens/changePassword.dart';
import 'package:mealmentor/screens/homepage_screen.dart';
import 'profile_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9DC08B), // Màu nền xanh lá
      body: Stack(
        children: [
          // Logo và form đăng nhập
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Column(
              children: [
                // Hình logo Meal Mentor
                Image.asset(
                  'images/logoApp.png', // Thay bằng hình ảnh thực tế của bạn
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                // Form đăng nhập
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tên đăng nhập:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // Text quên mật khẩu
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Khi nhấn vào "Bạn quên mật khẩu", mở BottomSheet
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Để cho phép full-height scroll
                        builder: (BuildContext context) {
                          return _buildForgotPasswordSheet(context);
                        },
                        backgroundColor: Colors.transparent, // Nền trong suốt
                      );
                    },
                    child: const Text(
                      'Bạn quên mật khẩu?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nút "Đăng nhập"
                ElevatedButton(
                  onPressed: () {
                    // Xử lý đăng nhập
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()), // Navigate to ProfileScreen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF40513B), // Màu xanh đậm cho nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 100),
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Nút "Đăng ký" ở dưới cùng, kéo lên để hiển thị
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0) {
                  // Khi kéo lên, mở bottom sheet "Đăng ký"
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // Để có thể scroll full-height
                    builder: (BuildContext context) {
                      return _buildRegisterSheet(context);
                    },
                    backgroundColor:
                        Colors.transparent, // Làm cho nền trong suốt
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF40513B), // Màu xanh đậm
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), // Bo tròn góc trên bên trái
                    topRight: Radius.circular(30), // Bo tròn góc trên bên phải
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đăng ký',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.keyboard_arrow_up, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo Bottom Sheet cho phần "Đăng ký"
  Widget _buildRegisterSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5, // Kích thước ban đầu của BottomSheet
      minChildSize: 0.5, // Kích thước nhỏ nhất
      maxChildSize: 0.85, // Kích thước lớn nhất khi kéo lên
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF609966), // Màu nền của form đăng ký
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              controller: scrollController, // Để có thể scroll khi kéo lên
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Đăng Ký',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tên đăng nhập',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Xác nhận mật khẩu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý đăng ký
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF40513B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 100),
                    ),
                    child: const Text(
                      'Đăng ký ngay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Hàm tạo Bottom Sheet cho phần "Quên mật khẩu"
  Widget _buildForgotPasswordSheet(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF609966), // Màu nền của form quên mật khẩu
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Quên mật khẩu',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Điền email của bạn',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Xử lý đặt lại mật khẩu
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(0xFF40513B), // Màu nút "Đặt lại mật khẩu"
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
            ),
            child: const Text(
              'Xác nhận',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
