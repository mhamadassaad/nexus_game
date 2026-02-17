import 'package:flutter/material.dart';
import 'package:nexus_game/authflow.dart';
import 'package:nexus_game/onbordingscreen/onbording.dart';
import 'package:nexus_game/register/login.dart';
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool _showOnboarding = true;

  @override
  Widget build(BuildContext context) {
    return _showOnboarding
        ? OnboardingScreen(
            onFinish: () {
              setState(() {
                _showOnboarding = false;
              });
            },
          )
        : const AuthFlow();
  }
}
