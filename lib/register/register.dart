import 'dart:ui';
//hata yekon el UI wad7 w lama bedi est3aml colors advance
import 'package:flutter/material.dart';
// lezm tekon bi kel class la a5aber el editer eno ana 3am echt8l flutter
import 'package:firebase_auth/firebase_auth.dart';
class RegisterScreen extends StatefulWidget {
  final VoidCallback onRegister;
  //hayda elo che8el la edam 
  final VoidCallback onGoToLogin;
  //hayda ra7 yero7 3ala login

  const RegisterScreen({
    super.key,
    required this.onRegister,
    required this.onGoToLogin,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  //Controller username 7ata ya3rf cho 3am yed5l el user
  final TextEditingController _emailController = TextEditingController();
  //Controller Email 7ata ya3rf cho 3am yed5l el user
  final TextEditingController _passwordController = TextEditingController();
  ////Controller Password 7ata ya3rf cho 3am yed5l el user
  ///FireBase Function Start
  // دالة التسجيل "المستقبلية"
Future<void> _registerUser() async {
  try {
    // 1. إرسال الإيميل والباسورد لـ Firebase
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(), // trim تمسح الفراغات الزائدة
      password: _passwordController.text.trim(),
    );

    // 2. إذا نجح التسجيل، ننتقل للخطوة التالية (مثلاً الصفحة الرئيسية)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Character Spawned Successfully!")),
    );
    
    widget.onRegister(); // استدعاء الـ Callback الأصلي

  } on FirebaseAuthException catch (e) {
    // 3. صيد أخطاء Firebase (إيميل مكرر، باسورد ضعيف، إلخ)
    String message = "Registration Failed";
    if (e.code == 'weak-password') {
      message = "The password is too weak!";
    } else if (e.code == 'email-already-in-use') {
      message = "Account already exists!";
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  } catch (e) {
    // خطأ غير متوقع
    print(e.toString());
  }
}
  ///FireBase Function End
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617), // slate-950
      body: Stack(
      //est3amlt stack 7ata waz3 el blur bi tari2a e7triafyeh
      // hayda 7asb el desing meno 7efz 
        children: [
          // الخلفية بنمط Black Linen
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                'https://www.transparenttextures.com/patterns/black-linen.png',
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),

          // توهج خلفي وردي (Pink Blur)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(),
              ),
            ),
          ),

          Center(
            //est3mlt ceneter la yekon kel shi bedi yeha bi nos el page
            child: SingleChildScrollView(
              //7ata enzl w etl3 
              padding: const EdgeInsets.all(24.0),
              //7ata a3ml mas7a bel screen
              child: ClipRRect(
              //7ata ess el atrf bi shakl da2ri
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                //7ata a3ti lam7a men el e2zaz ma3 lam3a jamdh
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  //7ata yebin el blur wad7
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A).withOpacity(0.8), // slate-900/80
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.pink.withOpacity(0.3)),
                    ),
                    child: Column(
                      //7ata ratab el oumr ta7t ba3da 
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // أيقونة Gamepad العلوية
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.pink.withOpacity(0.5)),
                          ),
                          child: const Icon(Icons.sports_esports, color: Colors.pinkAccent, size: 32),
                        ),
                        const SizedBox(height: 16),
                        
                        // العنوان الرئيسي
                        const Text(
                          "CREATE CHARACTER",
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 3,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            boxShadow: [
                              BoxShadow(color: Colors.pink.withOpacity(0.8), blurRadius: 10)
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // حقل اسم اللاعب (Player Handle)
                        _buildInputField(
                        //hayd function ma3molh bi alb nafs el class 3am ast3amla
                          label: "PLAYER HANDLE",
                          hint: "NoobMaster69",
                          icon: Icons.person_outline,
                          controller: _usernameController,
                        ),
                        const SizedBox(height: 20),

                        // حقل البريد (System Email)
                        _buildInputField(
                          label: "SYSTEM EMAIL",
                          hint: "gamer@relic.io",
                          icon: Icons.alternate_email,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 20),

                        // حقل الرمز السري (Security Pin)
                        _buildInputField(
                          label: "SECURITY PIN",
                          hint: "••••••••",
                          icon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                        ),

                        const SizedBox(height: 32),

                        // زر Spawn Now (الزر الأساسي بلون وردي متوهج)
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.withOpacity(0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            //el zer yali 3am yesir 3elh click
                           // onPressed: widget.onRegister,
                           onPressed: _registerUser, // بدلاً من widget.onRegister
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              "SPAWN NOW",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // العودة لتسجيل الدخول
                        Row(
                        //hon bedi 5ali 2 element 7ad ba3d yali hene
                        // Already a veteran? & Log In
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already a veteran? ", style: TextStyle(color: Color(0xFF94A3B8))),
                            GestureDetector(
                              onTap: widget.onGoToLogin,
                              child: const Text(
                                "Log In",
                                style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                              ),
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
//haydi el function yali 3am 3amla
// 3emlta 7ata ma ektob TextField kel mara hon masalm 3 marat
// kermal ma aktaba 3 marat w kaber el code 3emlta function 
//best3mla ma7al ma bedi yeah
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
        Text(
          label,
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF020617),
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF334155)),
            prefixIcon: Icon(icon, color: const Color(0xFF64748B)),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1E293B)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.pinkAccent, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}