import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/subscribe.dart'; // Make sure to import your SubscriptionScreen

class PickPackageScreen extends StatefulWidget {
  const PickPackageScreen({Key? key}) : super(key: key);

  @override
  _PickPackageScreenState createState() => _PickPackageScreenState();
}

class _PickPackageScreenState extends State<PickPackageScreen> {
  String? selectedPackage;
  String? selectedPaymentMethod;

  // List of packages
  final List<Package> packages = [
    Package(title: 'Gói Cơ Bản', description: 'Gói cơ bản cho người mới.', price: '100.000 VND'),
    Package(title: 'Gói Cao Cấp', description: 'Gói cao cấp với nhiều tính năng.', price: '200.000 VND'),
    Package(title: 'Gói VIP', description: 'Gói VIP cho những người yêu cầu cao.', price: '500.000 VND'),
  ];

  // List of payment methods
  final List<String> paymentMethods = ['Thẻ tín dụng', 'Chuyển khoản ngân hàng', 'Thanh toán khi nhận hàng'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn Gói Đăng Ký'), // Title for the screen
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Chọn gói đăng ký phù hợp với bạn:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          // Package selection
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: packages.map((package) {
                return RadioListTile<String>(
                  title: Text(package.title),
                  subtitle: Text(package.description),
                  value: package.title,
                  groupValue: selectedPackage,
                  activeColor: Colors.green, // Set the active color to green
                  onChanged: (value) {
                    setState(() {
                      selectedPackage = value; // Update the selected package
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(), // Divider between sections
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Chọn phương thức thanh toán:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          // Payment method selection
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: paymentMethods.map((method) {
                return RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: selectedPaymentMethod,
                  activeColor: Colors.green, // Set the active color to green
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value; // Update the selected payment method
                    });
                  },
                );
              }).toList(),
            ),
          ),
          // Confirm button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center( // Center the button
              child: SizedBox(
                width: double.infinity, // Make the button full width
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPackage != null && selectedPaymentMethod != null) {
                      // Navigate to SubscriptionScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubscriptionScreen(), // Make sure to import this screen
                        ),
                      );
                    } else {
                      // Show an error message if selections are not made
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vui lòng chọn gói đăng ký và phương thức thanh toán.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Xác nhận'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Package {
  final String title;
  final String description;
  final String price;

  Package({
    required this.title,
    required this.description,
    required this.price,
  });
} 