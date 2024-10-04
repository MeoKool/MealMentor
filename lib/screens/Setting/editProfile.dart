import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/profile_screen.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB5D6A0), // light green
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back action
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        color: Color(0xFFB5D6A0), // same light green background
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
              child: Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }
}
