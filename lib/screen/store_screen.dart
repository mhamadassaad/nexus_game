import 'package:flutter/material.dart';
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: const Color(0xFF020A12), // الخلفية الغامقة جداً
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'LOADED CARGO',
                style: TextStyle(
                  color: Color(0xFF00E5FF), // اللون السماوي الفاقع
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 30),
              // قائمة العناصر
              const CargoItem(title: 'ITEM NEXUS #1', price: 499.00),
              const SizedBox(height: 15),
              const CargoItem(title: 'ITEM NEXUS #2', price: 499.00),
              const Spacer(),
              // منطقة المجموع النهائي
              const SummarySection(),
              const SizedBox(height: 20),
              // زر Checkout
              const InitializeCheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
class CargoItem extends StatelessWidget {
  final String title;
  final double price;

  const CargoItem({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1221),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // صورة افتراضية (مكان الصورة في التصميم)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.image, color: Colors.white24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 18),
                ),
                const SizedBox(height: 10),
                // أزرار التحكم بالكمية
                Row(
                  children: [
                    const QuantityControl(),
                    const Spacer(),
                    Icon(Icons.delete_outline, color: Colors.pink[400], size: 22),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class QuantityControl extends StatelessWidget {
  const QuantityControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.remove, size: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Icon(Icons.add, size: 16),
        ],
      ),
    );
  }
}
class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1221),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _buildRow('SUBTOTAL', '\$998.00'),
          const SizedBox(height: 10),
          _buildRow('TAX RATE', '\$42.00'),
          const Divider(color: Colors.white24, height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('GRAND TOTAL', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold)),
              Text('\$1,040.00', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
class InitializeCheckoutButton extends StatelessWidget {
  const InitializeCheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00E5FF),
          foregroundColor: Colors.black,
          shape: const BeveledRectangleBorder( // يعطي الزوايا المائلة مثل التصميم
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
        onPressed: () {},
        child: const Text(
          'INITIALIZE CHECKOUT',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
      ),
    );
  }
}