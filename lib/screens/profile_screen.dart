import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9DC08B), // Màu nền xanh lá nhạt
      body: Column(
        children: [
          // Phần trên cùng với hình ảnh và logo
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 220,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'images/headerImage.png'), // Hình ảnh phía trên
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 160,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: Column(
                  children: [
                    Image.asset(
                      'images/logoApp.png', // Logo của bạn
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 80), // Khoảng cách để logo và danh sách không bị trùng
          // Phần danh sách các mục
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: const [
                ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('Thông tin cá nhân'),
                ),
                ListTile(
                  leading: Icon(Icons.contact_mail_outlined),
                  title: Text('Liên hệ'),
                ),
                ListTile(
                  leading: Icon(Icons.menu_book_outlined),
                  title: Text('Thực đơn'),
                ),
                ListTile(
                  leading: Icon(Icons.favorite_outline),
                  title: Text('Yêu thích'),
                ),
                ListTile(
                  leading: Icon(Icons.subscriptions_outlined),
                  title: Text('Gói đăng ký'),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF609966), // Màu của FAB ở giữa
        child: const Icon(Icons.restaurant_menu),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xFF609966), // Màu của BottomBar
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: Colors.black,
                onPressed: () {
                  // Chuyển đến trang Home
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                color: Colors.black,
                onPressed: () {
                  // Chuyển đến trang Tìm kiếm
                },
              ),
              const SizedBox(width: 48), // Khoảng trống cho FAB ở giữa
              IconButton(
                icon: const Icon(Icons.notifications),
                color: Colors.black,
                onPressed: () {
                  // Chuyển đến trang thông báo
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.black,
                onPressed: () {
                  // Chuyển đến trang cài đặt
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
