import 'package:flutter/material.dart';
import 'package:mealmentor/screens/Setting/pickpackage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePage();
}

class _FavouritePage extends State<FavouritePage>
    with AutomaticKeepAliveClientMixin {
  String username = '';
  String token = '';
  String userId = '';
  String email = '';
  bool subscribe = false;
  List<String> recipeList = [];
  List<dynamic> recipes = [];
  bool subcribe = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      subscribe = prefs.getBool('subscribe') ?? false;
      email = prefs.getString('email') ?? '';
      userId = prefs.getString('userId') ?? '';
      recipeList = prefs.getStringList('recipeList') ?? [];
      subcribe = prefs.getBool('subcribe') ?? false;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite", style: TextStyle(color: Colors.grey)),
        backgroundColor: const Color(0xFF9dc08b),
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        color: const Color(0xFF9dc08b), // Light green background color
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: subcribe
            ? _buildFavouriteContent() // Show content if subscribed
            : _buildUpgradePrompt(
                context), // Show upgrade prompt if not subscribed
      ),
    );
  }

  // Widget to show content when subscribed
  Widget _buildFavouriteContent() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Yêu thích',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              FoodItem(iconData: Icons.cake, label: "Cupcake"),
              FoodItem(iconData: Icons.fastfood, label: "Burger"),
              FoodItem(iconData: Icons.local_pizza, label: "Pizza"),
              FoodItem(iconData: Icons.cookie, label: "Cookie"),
              FoodItem(iconData: Icons.fastfood, label: "Hot Dog"),
              FoodItem(iconData: Icons.cookie, label: "Cookie"),
              FoodItem(iconData: Icons.cake, label: "Cupcake"),
              FoodItem(iconData: Icons.fastfood, label: "Burger"),
              FoodItem(
                iconData: Icons.add,
                label: "Add",
                backgroundColor: Colors.green[200],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Widget to show upgrade prompt when not subscribed
  Widget _buildUpgradePrompt(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Vui lòng nâng cấp để mở khóa tính năng này",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PickPackageScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Nâng cấp ngay",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Define the FoodItem widget as a separate stateless widget
class FoodItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color? backgroundColor;

  const FoodItem({
    Key? key,
    required this.iconData,
    required this.label,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
