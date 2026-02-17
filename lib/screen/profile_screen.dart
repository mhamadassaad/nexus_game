import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFF020A12), // الخلفية الغامقة جداً
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            children: [
              // --- Header Section (Avatar + Name) ---
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00E5FF).withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                          border: Border.all(color: const Color(0xFF00E5FF), width: 1.5),
                        ),
                        child: const CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'), // استبدلها بصورتك
                        ),
                      ),
                      // نقطة الحالة الخضراء (Online Status)
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF020817), width: 3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CIPHER_VOID',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          fontFamily: 'Courier', // يعطي طابع تقني
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          _buildBadge('LVL 42', const Color(0xFF00E5FF)),
                          const SizedBox(width: 10),
                          _buildBadge('PLATINUM TIER', Colors.white70),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // --- Stats Cards (Achieved & G-Points) ---
              Row(
                children: [
                  _buildStatCard('240', 'ACHIEVED', const Color(0xFF00E5FF)),
                  const SizedBox(width: 15),
                  _buildStatCard('1,250', 'G-POINTS', const Color(0xFFE91E63)),
                ],
              ),

              const SizedBox(height: 30),

              // --- Menu Options Container ---
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1221),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  children: [
                    _buildMenuTile(Icons.view_in_ar_outlined, 'PAST EXPEDITIONS'),
                    _buildDivider(),
                    _buildMenuTile(Icons.shield_outlined, 'SECURITY PROTOCOLS'),
                    _buildDivider(),
                    _buildMenuTile(Icons.credit_card_outlined, 'PAYMENT CHANNELS'),
                    _buildDivider(),
                    _buildMenuTile(Icons.settings_outlined, 'SYSTEM PREFERENCES'),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // --- Terminate Session Button ---
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE91E63), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'TERMINATE SESSION',
                    style: TextStyle(
                      color: Color(0xFFE91E63),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ويلجيت لبناء الشارات الصغيرة (Badges)
  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
  // ويدجيت لبناء بطاقات الإحصائيات
  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1221),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
  // ويدجيت لبناء عناصر القائمة
  Widget _buildMenuTile(IconData icon, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Icon(icon, color: const Color(0xFF00E5FF), size: 22),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
    );
  }
  Widget _buildDivider() {
    return Divider(color: Colors.white.withOpacity(0.05), height: 1, indent: 20, endIndent: 20);
  }
