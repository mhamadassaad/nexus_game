import 'package:flutter/material.dart';
import 'package:nexus_game/navigation/gaming_bottom_navigation.dart';
import 'package:nexus_game/screen/categories_screen.dart';
import 'package:nexus_game/screen/home_screen.dart';
import 'package:nexus_game/screen/profile_screen.dart';
import 'package:nexus_game/screen/store_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  NavItem _current = NavItem.home;

  final _pages =  [
     HomePage(),
     CategoriesScreen(),
     StoreScreen(),
     ProfileScreen(),
    //_PlaceholderPage(title: 'HOME'),
   // _PlaceholderPage(title: 'CATEGORIES'),
    //_PlaceholderPage(title: 'STORE'),
    //_PlaceholderPage(title: 'PROFILE'),
  ];

  int get _index => NavItem.values.indexOf(_current);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: GamingBottomNavigation(
        current: _current,
        onChanged: (item) {
          setState(() => _current = item);
        },
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white24,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
