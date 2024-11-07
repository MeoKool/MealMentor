import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mealmentor/screens/changePassword.dart';
import 'package:mealmentor/screens/navigation_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // TextEditingController để quản lý dữ liệu nhập vào
  static final TextEditingController _usernameController =
      TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final TextEditingController _registerUserNameController =
      TextEditingController();
  static final TextEditingController _registerEmailController =
      TextEditingController();
  static final TextEditingController _registerPasswordController =
      TextEditingController();
  static final TextEditingController _registerConfirmPasswordController =
      TextEditingController();

  // Hàm đăng nhập
  Future<void> _login(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    final String apiUrl = 'https://meal-mentor.uydev.id.vn/api/Account/login';

    // Tạo dữ liệu đăng nhập
    final Map<String, dynamic> loginData = {
      "email": _usernameController.text.trim(),
      "password": _passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(loginData),
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var data = jsonDecode(response.body);
        String accessToken = data['data']['accessToken'];
        prefs.setString('token', accessToken);

        final verifyResponse = await http.get(
            Uri.parse('https://meal-mentor.uydev.id.vn/api/Account/me'),
            headers: {
              'Authorization': 'Bearer $accessToken',
            });

        if (verifyResponse.statusCode == 200) {
          var verifyData = jsonDecode(verifyResponse.body);
          prefs.setString('userId', verifyData['data']['id']);
          prefs.setString('username', verifyData['data']['username']);
          prefs.setString('email', verifyData['data']['email']);
          List<String> recipeList = List<String>.from(json
              .decode(verifyData['data']['recipeList'])
              .map((item) => item.toString()));
          prefs.setStringList('recipeList', recipeList);
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: "Đăng nhập thành công!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationMenu()),
          );
        }
      } else {
        Navigator.of(context).pop();
        _showDialog(context, "Đăng nhập thất bại",
            "Vui lòng kiểm tra lại thông tin đăng nhập.");
      }
    } catch (e) {
      _showDialog(context, "Lỗi", "Không thể kết nối đến máy chủ.");
    }
  }

  // Hàm đăng ký
  Future<void> _register(BuildContext context) async {
    final String registerUrl =
        'https://meal-mentor.uydev.id.vn/api/Account/register';

    // Tạo dữ liệu đăng ký
    final Map<String, dynamic> registerData = {
      "userName": _registerUserNameController.text.trim(),
      "email": _registerEmailController.text.trim(),
      "password": _registerPasswordController.text,
      "confirmPassword": _registerConfirmPasswordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(registerData),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      String statusCodeCheck = responseData['statusCode'].toString();

      if (statusCodeCheck == '200') {
        _showDialog1(context, "Đăng ký thành công",
            "Tài khoản của bạn đã được tạo thành công. Hãy đăng nhập.");
      } else {
        _showDialog(context, "Đăng ký thất bại", responseData['message']);
      }
    } catch (e) {
      _showDialog(context, "Lỗi", "Không thể kết nối đến máy chủ.");
    }
  }

  void _showDialog1(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("Xác nhận"),
              onPressed: () {
                Navigator.of(context).pop(); // Đóng Dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen()), // Thay NewPage bằng trang bạn muốn chuyển tới
                );
              },
            ),
          ],
        );
      },
    );
  }

  // Hàm hiển thị hộp thoại thông báo
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9DC08B),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logoApp.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),

                    // Form đăng nhập
                    _buildTextField("Email:", _usernameController, false),
                    const SizedBox(height: 20),
                    _buildTextField("Mật khẩu:", _passwordController, true),
                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return _buildForgotPasswordSheet(context);
                            },
                            backgroundColor: Colors.transparent,
                          );
                        },
                        child: const Text(
                          'Bạn quên mật khẩu?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        _login(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF40513B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40),
                        minimumSize: const Size(double.infinity, 50),
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
            ),
            // Nút "Đăng ký" luôn nằm ở dưới cùng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.primaryDelta! < 0) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return _buildRegisterSheet(context);
                      },
                      backgroundColor: Colors.transparent,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF40513B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
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
      ),
    );
  }

  // Hàm tạo TextField với TextEditingController
  Widget _buildTextField(
      String labelText, TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildRegisterSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF609966),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              controller: scrollController,
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
                _buildTextField(
                    "Tên đăng nhập", _registerUserNameController, false),
                const SizedBox(height: 20),
                _buildTextField("Email", _registerEmailController, false),
                const SizedBox(height: 20),
                _buildTextField("Mật khẩu", _registerPasswordController, true),
                const SizedBox(height: 20),
                _buildTextField("Xác nhận mật khẩu",
                    _registerConfirmPasswordController, true),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _register(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40513B),
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

  // Bottom Sheet cho phần "Quên mật khẩu"
  Widget _buildForgotPasswordSheet(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF609966),
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
          _buildTextField("Điền email của bạn", TextEditingController(), false),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF40513B),
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
