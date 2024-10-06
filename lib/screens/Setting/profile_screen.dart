import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/contact.dart';
import 'package:mealmentor/screens/Setting/favourite.dart';
import 'package:mealmentor/screens/Setting/subscribe.dart';
import 'package:mealmentor/screens/Setting/editProfile.dart';
import 'package:mealmentor/screens/Setting/pickpackage_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9DC08B), // Màu nền xanh lá nhạt
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Logo Meal Mentor
          Center(
            child: Image.asset(
              'assets/images/logoApp.png', // Đường dẫn đến logo của bạn
              width: 200,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Quản lí tài khoản',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Phần danh sách các mục
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline, size: 30),
                  title: const Text(
                    'Thông tin cá nhân',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.contact_mail_outlined, size: 30),
                  title: Text(
                    'Liên hệ',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactScreen(),
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.menu_book_outlined, size: 30),
                  title: Text(
                    'Thực đơn',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.favorite_outline, size: 30),
                  title: Text(
                    'Yêu thích',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouritePage(),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.subscriptions_outlined, size: 30),
                  title: const Text(
                    'Gói đăng ký',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PickPackageScreen(),
                      ),
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
