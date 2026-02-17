import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  // لستة البيانات (في حال بدك تضيف أصناف أكتر)
  final List<Map<String, String>> categories = [
    {'title': 'PERIPHERALS', 'image': 'https://via.placeholder.com/150'},
    {'title': 'COMPONENTS', 'image': 'https://via.placeholder.com/150'},
    {'title': 'DISPLAYS', 'image': 'https://via.placeholder.com/150'},
    {'title': 'AUDIO', 'image': 'https://via.placeholder.com/150'},
    {'title': 'FURNITURE', 'image': 'https://via.placeholder.com/150'},
    {'title': 'APPAREL', 'image': 'https://via.placeholder.com/150'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020A12), // اللون الغامق جداً
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. العنوان الكبير
              Text(
                'INVENTORY\nCLASSES',
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 25),

              // 2. حقل البحث (Search Bar)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1B2A),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white10),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search for gear class...',
                    hintStyle: TextStyle(color: Colors.white38),
                    prefixIcon: Icon(Icons.search, color: Colors.white38),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 3. شبكة الأصناف (Grid)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عنصرين بالسطر
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.2, // نسبة العرض للطول لضبط حجم الكارت
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(
                      categories[index]['title']!,
                      categories[index]['image']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت الكارد الخاص بالصنف
  Widget _buildCategoryCard(String title, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // الصورة الخلفية مع تأثير تعتيم
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
            // النص فوق الصورة
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1.2,
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