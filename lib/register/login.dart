import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nexus_game/screen/manscreen.dart';
import 'package:nexus_game/widget/CustomClipper/gamingbuttonclipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  final VoidCallback onGoToRegister;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onGoToRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _keepActive = false;
  //Function Login With FireBase
  Future<void> _signIn() async {
  try {
    // إظهار مؤشر تحميل (اختياري لكن احترافي)
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.cyan)),
    );

    // العملية الأساسية: تسجيل الدخول
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // إغلاق مؤشر التحميل
    Navigator.pop(context);

    // إذا نجح، ننتقل للشاشة الرئيسية
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainLayout()),
    );

  } on FirebaseAuthException catch (e) {
    Navigator.pop(context); // إغلاق التحميل عند الخطأ
    
    String message = "Authentication Failed";
    if (e.code == 'user-not-found') {
      message = "No player found with this email.";
    } else if (e.code == 'wrong-password') {
      message = "Incorrect password (Cipher).";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }
}
  //End Fucntio  Login With Firebase
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617), // slate-950
      body: Stack(
        children: [
          // خلفية بنمط الكربون أو نسيج غامق
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.network(
                'https://www.transparenttextures.com/patterns/carbon-fibre.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          // تأثيرات الإضاءة المتوهجة (Blobs)
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70), child: Container()),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A).withOpacity(0.8), // slate-900/80
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.cyan.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // العنوان - Identify Player
                        const Text(
                          "IDENTIFY PLAYER",
                          style: TextStyle(
                            color: Color(0xFF22D3EE),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 4,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            boxShadow: [
                              BoxShadow(color: Colors.cyan.withOpacity(0.6), blurRadius: 10)
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // حقل النتوورك ID
                        _buildInputField(
                          label: "NETWORK ID",
                          hint: "commander@nexus.dev",
                          icon: Icons.mail_outline,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 24),

                        // حقل كلمة السر
                        _buildInputField(
                          label: "ACCESS CODE",
                          hint: "••••••••",
                          icon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        
                        const SizedBox(height: 16),

                        // خيارات إضافية
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _keepActive,
                                  activeColor: Colors.cyan,
                                  checkColor: Colors.black,
                                  onChanged: (val) => setState(() => _keepActive = val!),
                                ),
                                const Text("Keep active", style: TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Cipher?", style: TextStyle(color: Colors.cyan, fontSize: 12)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // زر الدخول الرئيسي
                       GamingButton(
                              label: "ENTER NEXUS",
                             variant: GamingButtonVariant.primary,
                             width: double.infinity,
                               height: 56,
                               onPressed: _signIn,
                        //        () {
                        //        // ننتقل لصفحة MainScreen عند الضغط
                        //        Navigator.pushReplacement(
                        //        context,
                        //      MaterialPageRoute(builder: (_) => const MainLayout()),
                        //    );
                        // },
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                       ),

                        const SizedBox(height: 24),

                        // فواصل "Or connect via"
                        Row(
                          children: [
                            const Expanded(child: Divider(color: Color(0xFF1E293B))),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text("OR CONNECT VIA", style: TextStyle(color: Colors.grey.shade600, fontSize: 10)),
                            ),
                            const Expanded(child: Divider(color: Color(0xFF1E293B))),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // أزرار التواصل الاجتماعي
                        Row(
                          children: [
                            _buildSocialButton("GOOGLE",),
                            const SizedBox(width: 16),
                            _buildSocialButton("DISCORD"),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // إنشاء حساب جديد
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("New player? ", style: TextStyle(color: Colors.grey)),
                            GestureDetector(
                              onTap: widget.onGoToRegister,
                              child: const Text("Create Character", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 10, letterSpacing: 2)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF020617),
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF475569)),
            prefixIcon: Icon(icon, color: const Color(0xFF475569)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1E293B)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.cyan),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String label, {bool isImage = false}) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF020617),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF1E293B)),
        ),
        child: Center(
          child: isImage 
            ? Image.network('https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg', height: 20)
            : Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}