import 'package:flutter/material.dart';

class NexusHomePage extends StatefulWidget {
  const NexusHomePage({super.key});

  @override
  State<NexusHomePage> createState() => _NexusHomePageState();
}

class _NexusHomePageState extends State<NexusHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617), // اللون الداكن الأساسي
      body: Stack(
        children: [
          // المحتوى القابل للتمرير
          ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildHeader(),
              _buildHeroSection(),
              _buildQuickActions(),
              _buildTopRatedSection(),
              _buildFlashSalesSection(),
              const SizedBox(height: 100), // مساحة إضافية عشان الـ Nav Bar
            ],
          ),
          
          // شريط التنقل السفلي المخصص (Custom Bottom Nav)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNavBar(),
          ),
        ],
      ),
    );
  }

  // 1. Header (App Bar)
  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5E9),
                borderRadius: BorderRadius.circular(6),
                boxShadow: [BoxShadow(color: Colors.cyan.withOpacity(0.6), blurRadius: 10)],
              ),
              child: const Icon(Icons.videogame_asset, color: Colors.black, size: 24),
            ),
            const Text(
              "NEXUS GEAR",
              style: TextStyle(
                color: Color(0xFF22D3EE),
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.search, color: Colors.white70, size: 28),
                const SizedBox(width: 15),
                Stack(
                  children: [
                    const Icon(Icons.shopping_cart_outlined, color: Colors.white70, size: 28),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Color(0xFFEC4899), shape: BoxShape.circle),
                        child: const Text("3", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                const Icon(Icons.person_outline, color: Colors.white70, size: 28),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 2. Hero Section (Elite Loadout Drop)
  Widget _buildHeroSection() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://picsum.photos/seed/loadout/800/400"), // صورة غيوم/ضباب
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [const Color(0xFF020617), Colors.black.withOpacity(0.1)],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("SEASON PASS EXCLUSIVE", style: TextStyle(color: Color(0xFF22D3EE), fontSize: 12, fontWeight: FontWeight.bold)),
            const Text("ELITE LOADOUT DROP", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: index == 2 ? 15 : 5,
                height: 3,
                color: index == 2 ? const Color(0xFF22D3EE) : Colors.white24,
              )),
            )
          ],
        ),
      ),
    );
  }

  // 3. Quick Actions (Boost, Defense, Trophy...)
  Widget _buildQuickActions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          _buildActionCard("BOOST", Icons.bolt, Colors.yellow),
          _buildActionCard("DEFENSE", Icons.shield_outlined, Colors.blue),
          _buildActionCard("TROPHY", Icons.emoji_events_outlined, Colors.orange),
          _buildActionCard("HOT DEALS", Icons.whatshot, Colors.red),
        ],
      ),
    );
  }

  Widget _buildActionCard(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ClipPath(
        clipper: BeveledClipper(),
        child: Container(
          width: 100,
          height: 100,
          color: const Color(0xFF0F172A),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  // 4. Top Rated Gear (Grid)
  Widget _buildTopRatedSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.emoji_events, color: Colors.yellow, size: 20),
                  SizedBox(width: 8),
                  Text("TOP RATED GEAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                ],
              ),
              TextButton(onPressed: () {}, child: const Text("VIEW ALL", style: TextStyle(color: Color(0xFF22D3EE), fontSize: 12))),
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 0.75,
          children: [
            _buildProductCard("RTX 5090 Ti Ultra", "GPUS", "1599", "4.9", "https://picsum.photos/seed/gpu/300"),
            _buildProductCard("Nexus Keyboard", "PERIPHERALS", "129", "4.8", "https://picsum.photos/seed/kb/300"),
            _buildProductCard("Dragon Mouse", "PERIPHERALS", "89", "4.7", "https://picsum.photos/seed/mouse/300"),
            _buildProductCard("OLED 360Hz", "MONITORS", "699", "4.9", "https://picsum.photos/seed/mon/300"),
          ],
        ),
      ],
    );
  }

  Widget _buildProductCard(String name, String cat, String price, String rate, String img) {
    return ClipPath(
      clipper: BeveledClipper(),
      child: Container(
        color: const Color(0xFF0F172A),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(img, height: 120, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  top: 8, right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                    child: Row(children: [const Icon(Icons.star, color: Colors.yellow, size: 10), Text(" $rate", style: const TextStyle(color: Colors.white, fontSize: 10))]),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cat, style: const TextStyle(color: Color(0xFF22D3EE), fontSize: 9, fontWeight: FontWeight.bold)),
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$$price", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: const Color(0xFF22D3EE), borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.add_shopping_cart, size: 16, color: Colors.black),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // 5. Flash Sales Section
  Widget _buildFlashSalesSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEC4899).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.whatshot, color: Color(0xFFEC4899)),
                  SizedBox(width: 8),
                  Text("FLASH SALES", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22, shadows: [Shadow(color: Color(0xFFEC4899), blurRadius: 10)])),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFEC4899), borderRadius: BorderRadius.circular(15)),
                child: const Text("04:22:15", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 20),
          _buildFlashItem("Pro Gaming Chair", "FURNITURE", "299", "20", "https://picsum.photos/seed/chair/200"),
          const SizedBox(height: 10),
          _buildFlashItem("Hyper Headset", "AUDIO", "159", "15", "https://picsum.photos/seed/audio/200"),
        ],
      ),
    );
  }

  Widget _buildFlashItem(String name, String cat, String price, String disc, String img) {
    return Container(
      height: 90,
      decoration: BoxDecoration(color: const Color(0xFF020617), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(img, width: 90, height: 90, fit: BoxFit.cover)),
              Container(
                padding: const EdgeInsets.all(4),
                color: const Color(0xFFEC4899),
                child: Text("-$disc%", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cat, style: const TextStyle(color: Color(0xFFEC4899), fontSize: 9, fontWeight: FontWeight.bold)),
                  Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("\$$price", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ),
          const Icon(Icons.shopping_cart_outlined, color: Color(0xFFEC4899), size: 24),
          const SizedBox(width: 15),
        ],
      ),
    );
  }

  // 6. Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF020617),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavIcon(Icons.home_filled, "HOME", true),
          _buildNavIcon(Icons.grid_view_rounded, "", false),
          _buildNavIcon(Icons.shopping_cart_outlined, "", false),
          _buildNavIcon(Icons.person_outline, "", false),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, String label, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (active) Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFF22D3EE), borderRadius: BorderRadius.circular(2), boxShadow: [BoxShadow(color: Colors.cyan.withOpacity(0.8), blurRadius: 8)])),
        const SizedBox(height: 8),
        Icon(icon, color: active ? const Color(0xFF22D3EE) : Colors.white38, size: 28),
        if (label.isNotEmpty) Text(label, style: const TextStyle(color: Color(0xFF22D3EE), fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// كلاس لعمل الزوايا المقصوصة Beveled Edges
class BeveledClipper extends CustomClipper<Path> {
  @override
  Path getPath(Size size) {
    Path path = Path();
    double cut = 15.0;
    
    // رسم المسار مع الزاوية المقصوصة (Beveled Edge)
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - cut);
    path.lineTo(size.width - cut, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    return path;
  }

  // هذه هي الدالة التي كانت تنقصك
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // نرجع false إذا كان التصميم ثابتاً ولا يحتاج لإعادة حساب المسار في كل إطار
    return false; 
  }
  
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    throw UnimplementedError();
  }
}