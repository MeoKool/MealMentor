import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealmentor/screens/Setting/subscribe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';


class PickPackageScreen extends StatefulWidget {
  const PickPackageScreen({Key? key}) : super(key: key);

  @override
  _PickPackageScreenState createState() => _PickPackageScreenState();
}

class _PickPackageScreenState extends State<PickPackageScreen> {
  String token = "";
  String? selectedPackage;
  String? selectedPaymentMethod;

  final List<Package> packages = [
    Package(
        title: 'Gói Cơ Bản',
        description: 'Gói cơ bản cho người mới.',
        price: '50.000 VND'),
  ];

  final List<String> paymentMethods = [
    'Thanh toán bằng Payos',
  ];

  @override
  void initState() {
    super.initState();
    selectedPackage = packages.first.title;
    selectedPaymentMethod = paymentMethods.first;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      token = pre.getString('token') ?? "";
    });
  }

  // Future<void> initiatePayment() async {
  //   final url =
  //       Uri.parse('https://meal-mentor.uydev.id.vn/api/Payment/create-link');
  //   final body = {"amount": 50000, "description": "Subscription Meal Mentor"};

  //   final response = await http.post(
  //     url,
  //     headers: {"Authorization": 'Bearer $token'},
  //   );

  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     if (responseData['error'] == 0) {
  //       final checkoutUrl = responseData['data']['checkoutUrl'];
  //       if (kIsWeb) {
  //         // If running on web, open the URL in a new tab
  //         await launchUrl(Uri.parse(checkoutUrl), mode: LaunchMode.externalApplication);
  //       } else {
  //         // If running on mobile, navigate to the WebView
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => PaymentWebView(url: checkoutUrl),
  //           ),
  //         );
  //       }
  //     } else {
  //       _showErrorSnackBar(responseData['message']);
  //     }
  //   } else {
  //     _showErrorSnackBar("Failed to initiate payment.");
  //   }
  // }
Future<void> initiatePayment() async {
  final url =
      Uri.parse('https://meal-mentor.uydev.id.vn/api/Payment/create-link');
  final body = {"amount": 50000, "description": "Subscription Meal Mentor"};

  final response = await http.post(
    url,
    headers: {"Authorization": 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData['error'] == 0) {
      final checkoutUrl = responseData['data']['checkoutUrl'];
      if (kIsWeb) {
        // If running on web, open the URL in a new tab
        await launchUrl(Uri.parse(checkoutUrl), mode: LaunchMode.externalApplication);
      } else {
        // If running on mobile, navigate to the WebView
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentWebView(url: checkoutUrl),
          ),
        );
      }
    } else {
      _showErrorSnackBar(responseData['message']);
    }
  } else {
    _showErrorSnackBar("Failed to initiate payment.");
  }
}
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final package = packages[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: RadioListTile<String>(
                            title: Text(package.title,
                                style: const TextStyle(color: Colors.black)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(package.description,
                                    style:
                                        const TextStyle(color: Colors.black)),
                                const SizedBox(height: 5),
                                Text(
                                  package.price,
                                  style: const TextStyle(
                                      color: Color(0xFF40513B),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            value: package.title,
                            groupValue: selectedPackage,
                            activeColor: const Color(0xFF40513B),
                            onChanged: (value) {
                              setState(() {
                                selectedPackage = value;
                              });
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(color: Colors.white),
                    const Text(
                      'Chọn phương thức thanh toán:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: paymentMethods.map((method) {
                        return RadioListTile<String>(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(method,
                                  style: const TextStyle(color: Colors.white)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/payos.png',
                                  width: 35,
                                  height: 35,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          value: method,
                          groupValue: selectedPaymentMethod,
                          activeColor: const Color(0xFF40513B),
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentMethod = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedPackage != null &&
                          selectedPaymentMethod != null) {
                        initiatePayment();
                      } else {
                        _showErrorSnackBar(
                            'Vui lòng chọn gói đăng ký và phương thức thanh toán.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF40513B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 100),
                    ),
                    child: const Text('Xác nhận',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
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

// class PaymentWebView extends StatelessWidget {
//   final String url;

//   const PaymentWebView({Key? key, required this.url}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Thanh toán"),
//       ),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }
class PaymentWebView extends StatelessWidget {
  final String url;

  const PaymentWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thanh toán"),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          final uri = Uri.parse(request.url);

          if (uri.queryParameters['status'] == 'CANCELLED') {
            Navigator.pop(context); // Close WebView
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CancelScreen(),
              ),
            );
            return NavigationDecision.prevent;
          } else if (uri.queryParameters['status'] == 'PAID') {
            Navigator.pop(context); // Close WebView
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessScreen(),
              ),
            );
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}

class CancelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán thất bại')),
      body: Center(
        child: const Text(
          'Thanh toán đã bị hủy.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thanh toán thành công')),
      body: Center(
        child: const Text(
          'Thanh toán thành công! Cảm ơn bạn.',
          style: TextStyle(fontSize: 18),
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
