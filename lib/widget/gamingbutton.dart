import 'package:flutter/material.dart';
import 'package:nexus_game/widget/variant.dart';
class GamingButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final GamingButtonVariant variant;

  // extensibility
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final bool enabled;

  const GamingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = GamingButtonVariant.primary,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // placeholder
  }
}
// _GamingButtonStyle
class _GamingButtonStyle {
  final Color background;
  final Color foreground;
  final Color border;
  final Color glow;

  const _GamingButtonStyle({
    required this.background,
    required this.foreground,
    required this.border,
    required this.glow,
  });
}
_GamingButtonStyle _styleForVariant(GamingButtonVariant variant) {
  switch (variant) {
    case GamingButtonVariant.primary:
      return const _GamingButtonStyle(
        background: Color(0xFF22D3EE),
        foreground: Color(0xFF020617),
        border: Color(0xFF67E8F9),
        glow: Color(0xFF22D3EE),
      );

    case GamingButtonVariant.secondary:
      return const _GamingButtonStyle(
        background: Color(0xFF1E293B),
        foreground: Color(0xFF22D3EE),
        border: Color(0xFF475569),
        glow: Color(0x3322D3EE),
      );

    case GamingButtonVariant.danger:
      return const _GamingButtonStyle(
        background: Color(0xFFEC4899),
        foreground: Colors.white,
        border: Color(0xFFF472B6),
        glow: Color(0xFFEC4899),
      );
  }
}
