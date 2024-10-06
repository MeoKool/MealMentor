import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/subscribe.dart';

class PickPackageScreen extends StatefulWidget {
  const PickPackageScreen({Key? key}) : super(key: key);

  @override
  _PickPackageScreenState createState() => _PickPackageScreenState();
}

class _PickPackageScreenState extends State<PickPackageScreen> {
  String? selectedPackage; // To store the selected package
  String? selectedPaymentMethod; // To store the selected payment method

  // List of packages
  final List<Package> packages = [
    Package(
        title: 'Gói Cơ Bản',
        description: 'Gói cơ bản cho người mới.',
        price: '100.000 VND'),
    Package(
        title: 'Gói Cao Cấp',
        description: 'Gói cao cấp với nhiều tính năng.',
        price: '200.000 VND'),
    Package(
        title: 'Gói VIP',
        description: 'Gói VIP cho những người yêu cầu cao.',
        price: '500.000 VND'),
  ];

  // List of payment methods
  final List<String> paymentMethods = [
    'Thẻ tín dụng',
    'Chuyển khoản ngân hàng',
    'Thanh toán khi nhận hàng'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF40513B),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Chọn Gói Đăng Ký',
            style: TextStyle(color: Colors.white)), // Title for the screen
      ),
      body: Container(
        color: const Color(0xFF9DC08B), // Set the background color to green
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Chọn gói đăng ký phù hợp với bạn:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white), // Text color for visibility
            ),
            const SizedBox(height: 20),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Package selection section
                    ListView.separated(
                      // Use ListView.separated for automatic dividers
                      itemCount: packages.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 10), // Space between items
                      shrinkWrap: true, // Make it wrap the content height
                      physics: NeverScrollableScrollPhysics(), // Disable scrolling
                      itemBuilder: (context, index) {
                        final package = packages[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255), // Set the background color
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // Shadow for depth
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3), // Changes position of shadow
                              ),
                            ],
                          ),
                          child: RadioListTile<String>(
                            title: Text(package.title,
                                style: const TextStyle(
                                    color: Colors.black)), // Change text color
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(package.description,
                                    style: const TextStyle(
                                        color: Colors.black)), // Change text color
                                const SizedBox(height: 5),
                                Text(
                                  package.price,
                                  style: const TextStyle(
                                      color: Color(0xFF40513B),
                                      fontWeight: FontWeight.bold), // Change price color for visibility
                                ),
                              ],
                            ),
                            value: package.title,
                            groupValue: selectedPackage,
                            activeColor:
                                const Color(0xFF40513B), // Change the active color
                            onChanged: (value) {
                              setState(() {
                                selectedPackage = value; // Update the selected package
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(color: Colors.white), // White divider for visibility
                    const Text(
                      'Chọn phương thức thanh toán:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white), // Text color for visibility
                    ),
                    const SizedBox(height: 10),
                    // Payment method selection with radio buttons
                    Column(
                      children: paymentMethods.map((method) {
                        return RadioListTile<String>(
                          title: Text(method,
                              style: const TextStyle(
                                  color: Colors.white)), // Change text color
                          value: method,
                          groupValue: selectedPaymentMethod,
                          activeColor: const Color(0xFF40513B), // Change the active color
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentMethod =
                                  value; // Update the selected payment method
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Confirm button
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                // Center the button
                child: SizedBox(
                  width: double.infinity, // Make the button full width
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedPackage != null &&
                          selectedPaymentMethod != null) {
                        // Navigate to the existing SubscriptionScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscriptionScreen(),
                          ),
                        );
                      } else {
                        // Show an error message if selections are not made
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Vui lòng chọn gói đăng ký và phương thức thanh toán.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF40513B), // Màu nút Trở về
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 100,
                      ),
                    ),
                    child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ],
        ),
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
