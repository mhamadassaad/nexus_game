import 'dart:ui';
import 'package:flutter/material.dart';

class GamingNavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const GamingNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<GamingNavItem> createState() => _GamingNavItemState();
}

class _GamingNavItemState extends State<GamingNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = Colors.cyan;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon + glow
              Stack(
                children: [
                  if (widget.isActive)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: activeColor.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  Icon(
                    widget.icon,
                    size: 26,
                    color: widget.isActive
                        ? activeColor
                        : Colors.white.withOpacity(0.6),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Underline indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 3,
                width: widget.isActive ? 24 : 0,
                decoration: BoxDecoration(
                  color: activeColor,
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color: activeColor.withOpacity(0.8),
                            blurRadius: 10,
                          )
                        ]
                      : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
