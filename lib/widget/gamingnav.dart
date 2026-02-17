import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nexus_game/widget/CustomClipper/gamingbuttonclipper.dart';

enum ViewState { home, store, inventory, profile }

class GamingNavigationBar extends StatefulWidget {
  final ViewState currentView;
  final Function(ViewState) onNavigate;

  const GamingNavigationBar({
    super.key,
    required this.currentView,
    required this.onNavigate,
  });

  @override
  State<GamingNavigationBar> createState() => _GamingNavigationBarState();
}

class _GamingNavigationBarState extends State<GamingNavigationBar> {
  Map<ViewState, bool> _isHovering = {
    ViewState.home: false,
    ViewState.store: false,
    ViewState.inventory: false,
    ViewState.profile: false,
  };

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'view': ViewState.home, 'label': 'Home', 'icon': LucideIcons.hdmiPort},
      {'view': ViewState.store, 'label': 'Store', 'icon': LucideIcons.gift},
      {'view': ViewState.inventory, 'label': 'Inventory', 'icon': LucideIcons.shoppingCart},
      {'view': ViewState.profile, 'label': 'Profile', 'icon': LucideIcons.user},
    ];

    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF020617).withOpacity(0.9),
        border: Border(top: BorderSide(color: Colors.cyan.withOpacity(0.5))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems.map((item) {
          final view = item['view'] as ViewState;
          final label = item['label'] as String;
          final iconData = item['icon'] as IconData;
          final isActive = widget.currentView == view;
          final isHover = _isHovering[view]!;

          return Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovering[view] = true),
              onExit: (_) => setState(() => _isHovering[view] = false),
              child: GestureDetector(
                onTap: () => widget.onNavigate(view),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      transform: Matrix4.identity()
                        ..scale(isHover || isActive ? 1.1 : 1.0),
                      child: GamingButton(
                        label: label,
                        onPressed: () => widget.onNavigate(view),
                        variant: isActive || isHover
                            ? GamingButtonVariant.primary
                            : GamingButtonVariant.secondary,
                        width: 100,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 4,
                      width: isActive ? 40 : 0,
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: Colors.cyan.withOpacity(0.7),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ]
                            : [],
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Label يظهر عند Hover فقط
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isActive || isHover ? 1.0 : 0.0,
                      child: Text(
                        label.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Orbitron',
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
