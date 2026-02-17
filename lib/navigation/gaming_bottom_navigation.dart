import 'package:flutter/material.dart';

enum NavItem { home, categories, store, profile }

class GamingBottomNavigation extends StatelessWidget {
  final NavItem current;
  final ValueChanged<NavItem> onChanged;

  const GamingBottomNavigation({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: const BoxDecoration(
        color: Color(0xFF020617), // dark navy
        border: Border(
          top: BorderSide(color: Color(0xFF0F172A)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavButton(
            icon: Icons.home_filled,
            label: 'HOME',
            active: current == NavItem.home,
            onTap: () => onChanged(NavItem.home),
          ),
          _NavButton(
            icon: Icons.grid_view_rounded,
            label: 'CATEGORIE',
            active: current == NavItem.categories,
            onTap: () => onChanged(NavItem.categories),
          ),
          _NavButton(
            icon: Icons.shopping_cart_outlined,
            label: 'STORE',
            active: current == NavItem.store,
            onTap: () => onChanged(NavItem.store),
          ),
          _NavButton(
            icon: Icons.person_outline,
            label: 'PROFILE',
            active: current == NavItem.profile,
            onTap: () => onChanged(NavItem.profile),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cyan = const Color(0xFF22D3EE);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: active ? cyan.withOpacity(0.12) : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: cyan.withOpacity(0.6),
                          blurRadius: 18,
                          spreadRadius: -6,
                        )
                      ]
                    : [],
              ),
              child: Icon(
                icon,
                size: active ? 26 : 24,
                color: active ? cyan : const Color(0xFF64748B),
              ),
            ),

            const SizedBox(height: 6),

            // LABEL يظهر فقط لو Active
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: active ? 1 : 0,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: cyan,
                  letterSpacing: 1.1,
                  shadows: [
                    Shadow(
                      color: cyan.withOpacity(0.8),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 4),

            // underline glow
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              height: 3,
              width: active ? 26 : 0,
              decoration: BoxDecoration(
                color: cyan,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: cyan.withOpacity(0.9),
                    blurRadius: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
