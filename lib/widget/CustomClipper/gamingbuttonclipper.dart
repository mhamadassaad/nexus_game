import 'package:flutter/material.dart';

enum GamingButtonVariant { primary, secondary, danger }

class GamingButtonStyle {
  final Color background;
  final Color border;
  final Color foreground;

  const GamingButtonStyle({
    required this.background,
    required this.border,
    required this.foreground,
  });
}

GamingButtonStyle _styleForVariant(GamingButtonVariant variant) {
  switch (variant) {
    case GamingButtonVariant.primary:
      return const GamingButtonStyle(
        background: Color(0xFF22D3EE),
        border: Color(0xFF67E8F9),
        foreground: Color(0xFF020617),
      );
    case GamingButtonVariant.secondary:
      return const GamingButtonStyle(
        background: Color(0xFF0F172A),
        border: Color(0xFF334155),
        foreground: Color(0xFF22D3EE),
      );
    case GamingButtonVariant.danger:
      return const GamingButtonStyle(
        background: Color(0xFFDB2777),
        border: Color(0xFFF472B6),
        foreground: Colors.white,
      );
  }
}

// Custom Clipper for polygon shape
class GamingButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const cut = 10.0;
    return Path()
      ..moveTo(cut, 0)
      ..lineTo(size.width - cut, 0)
      ..lineTo(size.width, cut)
      ..lineTo(size.width, size.height - cut)
      ..lineTo(size.width - cut, size.height)
      ..lineTo(cut, size.height)
      ..lineTo(0, size.height - cut)
      ..lineTo(0, cut)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Gaming Button Widget
class GamingButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final GamingButtonVariant variant;
  final bool enabled;
  final double width;
  final double height;
  final EdgeInsets padding;

  const GamingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = GamingButtonVariant.primary,
    this.enabled = true,
    this.width = 200,
    this.height = 56,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  @override
  State<GamingButton> createState() => _GamingButtonState();
}

class _GamingButtonState extends State<GamingButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (widget.enabled) setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.enabled) setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    if (widget.enabled) setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final style = _styleForVariant(widget.variant);

    // Scale factor for press animation
    final scale = _isPressed ? 0.95 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.enabled ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          transform: Matrix4.identity()..scale(scale),
          decoration: BoxDecoration(
            color: style.background,
            border: Border.all(color: style.border, width: 1.5),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.variant == GamingButtonVariant.danger
                          ? Colors.pinkAccent.withOpacity(0.6)
                          : Colors.cyan.withOpacity(0.6),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: ClipPath(
            clipper: GamingButtonClipper(),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: style.foreground,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  shadows: _isHovered
                      ? [
                          Shadow(
                            color: widget.variant == GamingButtonVariant.danger
                                ? Colors.pinkAccent
                                : Colors.cyan,
                            blurRadius: 8,
                          )
                        ]
                      : [],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
