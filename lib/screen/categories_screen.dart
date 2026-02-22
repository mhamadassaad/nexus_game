import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
  {'title': 'RPG GAMES', 'image': 'assets/images/c6.png'},
  {'title': 'ACTION BATTLE', 'image': 'assets/images/c5.png'},
  {'title': 'PRO KEYBOARDS', 'image': 'assets/images/c1.png'},
  {'title': 'ELITE HEADSETS', 'image': 'assets/images/c2.png'},
  {'title': 'SMART GEAR', 'image': 'assets/images/c4.png'},
  {'title': 'NEW RELEASES', 'image': 'assets/images/c3.png'},
];
    return Scaffold(
      backgroundColor: const Color(0xFF020A12),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. العنوان - تم تحسين الـ Style ليصبح أكثر حدة (Gaming Style)
              Text(
                'INVENTORY\nCLASSES',
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 25),

              // 2. حقل البحث المطوّر مع Border متوهج خفيف
              _buildSearchBar(),
              
              const SizedBox(height: 30),

              // 3. شبكة الأصناف
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.1, 
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

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.cyan.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search for gear class...',
          hintStyle: TextStyle(color: Colors.white24, fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.cyan, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath) {
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
            // استخدام Image.asset بدلاً من Network
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            
            // إضافة Gradient (تدرج لوني) لضمان وضوح النص دائماً
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),

            // النص في الزاوية السفلى مع تأثير Bold
            Positioned(
              bottom: 12,
              left: 12,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}