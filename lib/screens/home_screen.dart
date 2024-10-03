import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9DC08B), // Màu nền xanh lá nhạt
      body: Stack(
        children: [
          // Logo và hình nền
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Column(
              children: [
                // Hình logo Meal Mentor
                Image.asset(
                  'assets/images/logoApp.png',
                  width: 400,
                  height: 500,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Balance diet, Balance life',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Nút "Đăng nhập"
          Positioned(
            bottom: 60,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF40513B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Đăng nhập',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
