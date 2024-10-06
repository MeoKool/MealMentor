import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/subscribe.dart';

class PickPackageScreen extends StatefulWidget {
  const PickPackageScreen({Key? key}) : super(key: key);

  @override
  _PickPackageScreenState createState() => _PickPackageScreenState();
}

class _PickPackageScreenState extends State<PickPackageScreen> {
  String? selectedPackage; 
  String? selectedPaymentMethod; 

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
            style: TextStyle(color: Colors.white)), 
      ),
      body: Container(
        color: const Color(0xFF9DC08B), 
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
                  color: Colors.white), 
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      itemCount: packages.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      shrinkWrap: true,
                      physics:
                          NeverScrollableScrollPhysics(), 
                      itemBuilder: (context, index) {
                        final package = packages[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                                255, 255, 255, 255), 
                            borderRadius:
                                BorderRadius.circular(8.0), 
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1), 
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 3), 
                              ),
                            ],
                          ),
                          child: RadioListTile<String>(
                            title: Text(package.title,
                                style: const TextStyle(
                                    color: Colors.black)), 
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(package.description,
                                    style: const TextStyle(
                                        color:
                                            Colors.black)),
                                const SizedBox(height: 5),
                                Text(
                                  package.price,
                                  style: const TextStyle(
                                      color: Color(0xFF40513B),
                                      fontWeight: FontWeight
                                          .bold), 
                                ),
                              ],
                            ),
                            value: package.title,

                            groupValue: selectedPackage,
                            activeColor: const Color(
                                0xFF40513B), 
                            onChanged: (value) {
                              setState(() {
                                selectedPackage =
                                    value; 
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(
                        color: Colors.white), 
                    const Text(
                      'Chọn phương thức thanh toán:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white), 
                    ),
                    const SizedBox(height: 10),
                    // Payment method selection with radio buttons
                    Column(
                      children: paymentMethods.map((method) {
                        return RadioListTile<String>(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, 
                            children: [
                              Text(
                                method,
                                style: const TextStyle(
                                    color: Colors.white),
                              ),
                              Image.asset(
                                'assets/images/MoMo_Logo.png', 
                                width: 35,
                                height: 35, 
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          value: method,
                          groupValue: selectedPaymentMethod,
                          activeColor: const Color(
                              0xFF40513B), 
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentMethod =
                                  value; 
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
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedPackage != null &&
                          selectedPaymentMethod != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscriptionScreen(),
                          ),
                        );
                      } else {
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
                          const Color(0xFF40513B), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 100,
                      ),
                    ),
                    child: const Text('Xác nhận',
                        style: TextStyle(color: Colors.white,fontSize: 16)),
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
