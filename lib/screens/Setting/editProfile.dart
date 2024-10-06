import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/profile_screen.dart';
import 'package:mealmentor/screens/navigation_menu.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cá nhân", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF9dc08b),
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        color: Color(0xFF9dc08b), // same light green background
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Họ và tên',
                hintText: 'Imran Khan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'admin@uihut.com',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                hintText: '+84 01234 56789',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Handle confirmation action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF374A37), // dark green button
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Xác nhận',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
