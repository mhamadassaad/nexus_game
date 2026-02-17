import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020A12), // الخلفية الغامقة جداً
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.apps, color: Colors.cyan),
        title: Text('NEXUS GEAR', style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, letterSpacing: 2)),
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
  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://via.placeholder.com/600x300'), // حط صورة الغابة هون
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SEASON PASS EXCLUSIVE', style: TextStyle(color: Colors.cyan, fontSize: 12, fontWeight: FontWeight.bold)),
            Text('ELITE LOADOUT DROP', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 15, height: 4, color: Colors.grey),
                SizedBox(width: 5),
                Container(width: 30, height: 4, color: Colors.cyan),
                SizedBox(width: 5),
                Container(width: 15, height: 4, color: Colors.grey),
              ],
            )
          ],
        ),
      ),
    );
  }

  // لستة الـ Boosts الأفقية
  Widget _buildBoostList() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          return Container(
            width: 90,
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xFF101E2D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15), bottomRight: Radius.circular(3),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flash_on, color: Colors.yellow, size: 30),
                SizedBox(height: 10),
                Text('BOOST', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }

  // شبكة المنتجات (2x2)
  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.75,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return _buildProductCard();
        },
      ),
    );
  }

  // كارد المنتج الواحد
  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF0D1B2A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network('https://via.placeholder.com/150', fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GPUS', style: TextStyle(color: Colors.cyan, fontSize: 10)),
                Text('RTX 5090 Ti', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$1599', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(8)),
                      child: Icon(Icons.shopping_cart, size: 16, color: Colors.black),
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