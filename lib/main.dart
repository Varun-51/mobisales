import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const LuxuryApp());
}

// ─────────────────────────────────────────────
// GLOBAL THEME & COLORS
// ─────────────────────────────────────────────
class AppColors {
  static const primary      = Color(0xFF4A90E2);
  static const primaryLight = Color(0xFFEBF3FC);
  static const primaryDark  = Color(0xFF2D6BBF);
  static const white        = Color(0xFFFFFFFF);
  static const background   = Color(0xFFF8FAFE);
  static const surface      = Color(0xFFFFFFFF);
  static const textDark     = Color(0xFF1A2340);
  static const textMid      = Color(0xFF5A6580);
  static const textLight    = Color(0xFF9BA8BE);
  static const shadow       = Color(0x144A90E2);
  static const divider      = Color(0xFFEAEFF8);
}

ThemeData get appTheme => ThemeData(
  useMaterial3: true,
  fontFamily: 'Georgia',
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    surface: AppColors.surface,
    primary: AppColors.primary,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColors.textDark,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
    iconTheme: IconThemeData(color: AppColors.primary),
  ),
);

// ─────────────────────────────────────────────
// SHARED WIDGETS  (imported by both screens)
// ─────────────────────────────────────────────

/// Elegant card with a layered blue shadow.
class LuxuryCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const LuxuryCard({super.key, required this.child, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: AppColors.shadow, blurRadius: 24, offset: Offset(0, 8)),
            BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}

/// Gradient button with press-scale animation and loading state.
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween(begin: 1.0, end: 0.96)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5AA0ED), AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(color: Color(0x554A90E2), blurRadius: 20, offset: Offset(0, 8)),
            ],
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white, fontSize: 16,
                fontWeight: FontWeight.w600, letterSpacing: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Coloured pill badge (Confirmed / Pending / Draft).
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Reusable large page header with optional trailing action widget.
class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? action;

  const PageHeader({super.key, required this.title, required this.subtitle, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.w700,
                    color: AppColors.textDark, letterSpacing: -0.5, fontFamily: 'Georgia',
                  ),
                ),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(fontSize: 13, color: AppColors.textMid)),
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// APP ROOT
// ─────────────────────────────────────────────
class LuxuryApp extends StatelessWidget {
  const LuxuryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumina',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginScreen(),
    );
  }
}