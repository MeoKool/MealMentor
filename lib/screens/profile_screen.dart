import 'package:flutter/material.dart';
import 'package:mealmentor/screens/homepage_screen.dart';
import 'package:mealmentor/screens/subscribe.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      backgroundColor: const Color(0xFF9DC08B), // Màu nền xanh lá nhạt
      body: Column(
        children: [
          // Logo Meal Mentor
          const SizedBox(height: 100), // Khoảng cách phía trên
          Center(
            child: Image.asset(
              'assets/images/logoApp.png', // Logo của bạn
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Quản lí tài khoản',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 40),
          // Phần danh sách các mục
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('Thông tin cá nhân'),
                ),
                const ListTile(
                  leading: Icon(Icons.contact_mail_outlined),
                  title: Text('Liên hệ'),
                ),
                const ListTile(
                  leading: Icon(Icons.menu_book_outlined),
                  title: Text('Thực đơn'),
                ),
                const ListTile(
                  leading: Icon(Icons.favorite_outline),
                  title: Text('Yêu thích'),
                ),
                ListTile(
                  leading: const Icon(Icons.subscriptions_outlined),
                  title: const Text('Gói đăng ký'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SubscriptionScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
