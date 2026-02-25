import 'package:flutter/material.dart';
import 'main.dart';
import 'dashboard_screen.dart';

// ─────────────────────────────────────────────
// ELEGANT TEXT FIELD
// ─────────────────────────────────────────────
class ElegantTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final TextEditingController? controller;

  const ElegantTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.controller,
  });

  @override
  State<ElegantTextField> createState() => _ElegantTextFieldState();
}

class _ElegantTextFieldState extends State<ElegantTextField> {
  bool _focused  = false;
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _focused ? const Color(0x334A90E2) : const Color(0x0F000000),
            blurRadius: _focused ? 20 : 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: _focused ? AppColors.primary : AppColors.divider,
          width: _focused ? 1.5 : 1,
        ),
      ),
      child: Focus(
        onFocusChange: (f) => setState(() => _focused = f),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscure && _obscured,
          style: const TextStyle(
              color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 14),
            labelStyle: TextStyle(
              color: _focused ? AppColors.primary : AppColors.textMid,
              fontSize: 13, fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: _focused ? AppColors.primary : AppColors.textLight,
              size: 20,
            ),
            suffixIcon: widget.obscure
                ? IconButton(
              icon: Icon(
                _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColors.textLight, size: 20,
              ),
              onPressed: () => setState(() => _obscured = !_obscured),
            )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SOCIAL BUTTON
// ─────────────────────────────────────────────
class _SocialBtn extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialBtn({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
          boxShadow: const [
            BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.textDark, size: 22),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    color: AppColors.textDark, fontWeight: FontWeight.w500, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LOGIN SCREEN
// ─────────────────────────────────────────────
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailCtrl = TextEditingController(text: 'alex@lumina.co');
  final _passCtrl  = TextEditingController(text: '••••••••');
  bool _loading = false;

  late AnimationController _fadeCtrl;
  late Animation<double>   _fadeAnim;
  late Animation<Offset>   _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fadeAnim  = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const DashboardScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Decorative background blobs ──────────────────────
          Positioned(
            top: -80, right: -60,
            child: Container(
              width: 260, height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            bottom: 60, left: -80,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.05),
              ),
            ),
          ),

          // ── Main content ─────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.08),

                      // ── Logo block ──────────────────────────
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 72, height: 72,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6FB3F5), AppColors.primaryDark],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x554A90E2),
                                    blurRadius: 24, offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.bolt_rounded,
                                  color: Colors.white, size: 36),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Lumina',
                              style: TextStyle(
                                fontSize: 38, fontWeight: FontWeight.w700,
                                color: AppColors.textDark, letterSpacing: -0.5,
                                fontFamily: 'Georgia',
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Your premium workspace',
                              style: TextStyle(fontSize: 14, color: AppColors.textMid,
                                  letterSpacing: 0.3),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: size.height * 0.06),

                      // ── Login card ─────────────────────────────
                      LuxuryCard(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome back',
                              style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700,
                                color: AppColors.textDark, letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('Sign in to continue',
                                style: TextStyle(fontSize: 14, color: AppColors.textMid)),
                            const SizedBox(height: 28),

                            ElegantTextField(
                              label: 'Email address',
                              hint: 'you@example.com',
                              icon: Icons.mail_outline_rounded,
                              controller: _emailCtrl,
                            ),
                            const SizedBox(height: 16),
                            ElegantTextField(
                              label: 'Password',
                              hint: 'Your password',
                              icon: Icons.lock_outline_rounded,
                              obscure: true,
                              controller: _passCtrl,
                            ),

                            const SizedBox(height: 12),
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 13, fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),
                            PrimaryButton(
                              label: 'Sign In',
                              onPressed: _login,
                              isLoading: _loading,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── Divider ────────────────────────────────
                      const Row(
                        children: [
                          Expanded(child: Divider(color: AppColors.divider)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Text('or continue with',
                                style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                          ),
                          Expanded(child: Divider(color: AppColors.divider)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // ── Social buttons ─────────────────────────
                      const Row(
                        children: [
                          _SocialBtn(icon: Icons.g_mobiledata_rounded, label: 'Google'),
                          SizedBox(width: 16),
                          _SocialBtn(icon: Icons.apple_rounded, label: 'Apple'),
                        ],
                      ),

                      const SizedBox(height: 40),
                      Center(
                        child: RichText(
                          text: const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: AppColors.textMid, fontSize: 13),
                            children: [
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                    color: AppColors.primary, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}