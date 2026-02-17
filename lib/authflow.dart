import 'package:flutter/material.dart';
import 'package:nexus_game/register/login.dart';
import 'package:nexus_game/register/register.dart';
class AuthFlow extends StatefulWidget {
  const AuthFlow({super.key});

  @override
  State<AuthFlow> createState() => _AuthFlowState();
}

class _AuthFlowState extends State<AuthFlow> {
  bool _showLogin = true;

  @override
  Widget build(BuildContext context) {
    return _showLogin
        ? LoginScreen(
            onLogin: () {
              // TODO: بعد تسجيل الدخول
            },
            onGoToRegister: () {
              setState(() {
                _showLogin = false;
              });
            },
          )
        : RegisterScreen(
            onRegister: () {
              // TODO: بعد إنشاء الحساب
            },
            onGoToLogin: () {
              setState(() {
                _showLogin = true;
              });
            },
          );
  }
}
