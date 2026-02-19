import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
int _currentPage = 0; // لمراقبة الصفحة الحالية
final PageController _pageController = PageController(); // للتحكم في السلايدر

// قائمة البيانات: غير أسماء الصور لتطابق ما وضعته في مجلد الـ images
final List<Map<String, String>> _bannerItems = [
  {
    "image": "assets/images/s1.png", 
    "title": "ELITE LOADOUT DROP",
    "sub": "SEASON PASS EXCLUSIVE"
  },
  {
    "image": "assets/images/s2.png", 
    "title": "NEON STRIKE EVENT",
    "sub": "LIMITED TIME ONLY"
  },
  {
    "image": "assets/images/s3.png", 
    "title": "CYBER GEAR UP",
    "sub": "NEW ARRIVALS"
  },
];
//End For Images Slider
//For Row
final List<Map<String, String>> _boostItems = [
  {"image": "assets/images/r11.png", "title": "XP Headsets"},
  {"image": "assets/images/r22.png", "title": "Smart  Watch"},
  {"image": "assets/images/r33.png", "title": "Headsets"},
  {"image": "assets/images/r44.png", "title": "Controller"},
  {"image": "assets/images/r55.png", "title": "Keyboard"},
  {"image": "assets/images/r66.png", "title": "Microphone"},
];
//End For Row
//For Best Seller Item
final List<Map<String, String>> _products = [
  {
    "name": "Assassin's Creed ",
    "category": "RPG",
    "price": "\$40",
    "image": "assets/images/b1.png"
  },
  {
    "name": "Cyber Pank",
    "category": "Action",
    "price": "\$20",
    "image": "assets/images/b2.png"
  },
  {
    "name": "GTA 5",
    "category": "Action",
    "price": "\$15",
    "image": "assets/images/b3.png"
  },
  {
    "name": "Ghost of Tsushima",
    "category": "RPG",
    "price": "\$25",
    "image": "assets/images/b4.png"
  },
];
//End Best Seller Item
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020A12), // الخلفية الغامقة جداً
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.apps, color: Colors.cyan),
        title: Text('NEXUS Games', style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 15),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Icon(Icons.shopping_cart_outlined, color: Colors.white),
              CircleAvatar(radius: 6, backgroundColor: Colors.pink, child: Text('1', style: TextStyle(fontSize: 8)))
            ],
          ),
          SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Banner Section (Elite Loadout Drop)
            _buildBanner(),

            // 2. Boost Horizontal List
            SizedBox(height: 20),
            _buildBoostList(),

            // 3. Title "Best Seller"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Text(
                'Best Seller',
                style: TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // 4. Products Grid (2 elements per row)
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  // الـ Banner اللي فوق
  // Widget _buildBanner() {
  //   return Container(
  //     width: double.infinity,
  //     height: 200,
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image: NetworkImage('https://via.placeholder.com/600x300'), // حط صورة الغابة هون
  //         fit: BoxFit.cover,
  //         colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
  //       ),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('SEASON PASS EXCLUSIVE', style: TextStyle(color: Colors.cyan, fontSize: 12, fontWeight: FontWeight.bold)),
  //           Text('ELITE LOADOUT DROP', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
  //           SizedBox(height: 10),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(width: 15, height: 4, color: Colors.grey),
  //               SizedBox(width: 5),
  //               Container(width: 30, height: 4, color: Colors.cyan),
  //               SizedBox(width: 5),
  //               Container(width: 15, height: 4, color: Colors.grey),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _buildBanner() {
  return SizedBox(
    height: 220, // زيادة الطول قليلاً ليتناسب مع السلايدر
    width: double.infinity,
    child: Stack(
      children: [
        // 1. محرك الصور (PageView)
        PageView.builder(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: _bannerItems.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_bannerItems[index]['image']!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _bannerItems[index]['sub']!,
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      _bannerItems[index]['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30), // مساحة للنقاط في الأسفل
                  ],
                ),
              ),
            );
          },
        ),

        // 2. مؤشر النقاط (Dots Indicator)
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _bannerItems.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 4,
                width: _currentPage == index ? 30 : 15, // النقطة الحالية تكون أطول
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.cyan : Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: _currentPage == index
                      ? [BoxShadow(color: Colors.cyan.withOpacity(0.5), blurRadius: 5)]
                      : [],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  // لستة الـ Boosts الأفقية
  // Widget _buildBoostList() {
  //   return SizedBox(
  //     height: 120,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 6,
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       itemBuilder: (context, index) {
  //         return Container(
  //           width: 90,
  //           margin: EdgeInsets.symmetric(horizontal: 8),
  //           decoration: BoxDecoration(
  //             color: Color(0xFF101E2D),
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(15), topRight: Radius.circular(15),
  //               bottomLeft: Radius.circular(15), bottomRight: Radius.circular(3),
  //             ),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Icon(Icons.flash_on, color: Colors.yellow, size: 30),
  //               SizedBox(height: 10),
  //               Text('BOOST', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
Widget _buildBoostList() {
  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      // نعتمد على طول القائمة التي أنشأناها
      itemCount: _boostItems.length, 
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        return Container(
          width: 90,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF101E2D),
            // قمت بإضافة Border خفيف ليعطي شكل تقني (Techy look)
            border: Border.all(color: Colors.cyan.withOpacity(0.1)), 
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(3),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // استبدال الأيقونة بالصورة من الـ Assets
              Image.asset(
                _boostItems[index]['image']!,
                width: 45, // حجم مناسب للصورة داخل المربع
                height: 45,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              Text(
                _boostItems[index]['title']!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
  // شبكة المنتجات (2x2)
  // Widget _buildProductGrid() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //     child: GridView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 15,
  //         mainAxisSpacing: 15,
  //         childAspectRatio: 0.75,
  //       ),
  //       itemCount: 4,
  //       itemBuilder: (context, index) {
  //         return _buildProductCard();
  //       },
  //     ),
  //   );
  // }
Widget _buildProductGrid() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemCount: _products.length, // يعتمد على عدد المنتجات في القائمة
      itemBuilder: (context, index) {
        // نمرر بيانات المنتج الواحد بناءً على الـ index
        return _buildProductCard(_products[index]); 
      },
    ),
  );
}
  // كارد المنتج الواحد
  // Widget _buildProductCard() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Color(0xFF0D1B2A),
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20), topRight: Radius.circular(20),
  //         bottomLeft: Radius.circular(20), bottomRight: Radius.circular(5),
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //             child: Image.network('https://via.placeholder.com/150', fit: BoxFit.cover, width: double.infinity),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('GPUS', style: TextStyle(color: Colors.cyan, fontSize: 10)),
  //               Text('RTX 5090 Ti', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  //               SizedBox(height: 8),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text('\$1599', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
  //                   Container(
  //                     padding: EdgeInsets.all(5),
  //                     decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(8)),
  //                     child: Icon(Icons.shopping_cart, size: 16, color: Colors.black),
  //                   )
  //                 ],
  //               )
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  Widget _buildProductCard(Map<String, String> product) { // أضفنا بارامتر لاستقبال البيانات
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xFF0D1B2A),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(5),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              product['image']!, // استخدام Asset Image
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product['category']!, // الفئة من القائمة
                style: const TextStyle(color: Colors.cyan, fontSize: 10),
              ),
              Text(
                product['name']!, // الاسم من القائمة
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product['price']!, // السعر من القائمة
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.shopping_cart, size: 16, color: Colors.black),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
}