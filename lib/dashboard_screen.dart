import 'package:flutter/material.dart';
import 'main.dart';

// ─────────────────────────────────────────────
// DASHBOARD SCREEN  (BottomNavigation host)
// ─────────────────────────────────────────────
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const _pages = [
    VisitsPage(),
    ActivityPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOut,
        child: KeyedSubtree(
          key: ValueKey(_selectedIndex),
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: _LuxuryBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// LUXURY BOTTOM NAVIGATION BAR
// ─────────────────────────────────────────────
class _LuxuryBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _LuxuryBottomNav({required this.selectedIndex, required this.onTap});

  static const _items = [
    (icon: Icons.location_city_outlined,  activeIcon: Icons.location_city_rounded,  label: 'Visits'),
    (icon: Icons.show_chart_outlined,     activeIcon: Icons.show_chart_rounded,      label: 'Activity'),
    (icon: Icons.person_outline_rounded,  activeIcon: Icons.person_rounded,          label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(color: Color(0x18000000), blurRadius: 30, offset: Offset(0, -8)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item   = _items[i];
              final active = selectedIndex == i;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.symmetric(
                    horizontal: active ? 22 : 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: active ? AppColors.primaryLight : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? item.activeIcon : item.icon,
                        color: active ? AppColors.primary : AppColors.textLight,
                        size: 22,
                      ),
                      if (active) ...[
                        const SizedBox(width: 6),
                        Text(
                          item.label,
                          style: const TextStyle(
                            color: AppColors.primary, fontWeight: FontWeight.w600,
                            fontSize: 13, letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// TAB 1 — VISITS PAGE
// ══════════════════════════════════════════════
class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  static final _visits = [
    _VisitData(
      title: 'Oceanfront Penthouse',
      address: '142 Marina Blvd, Suite 12F',
      date: 'Tomorrow, 10:00 AM',
      status: 'Confirmed',
      statusColor: Color(0xFF34C88A),
      imageIcon: Icons.apartment_rounded,
    ),
    _VisitData(
      title: 'Midtown Office Tower',
      address: '55 Park Avenue, Floor 22',
      date: 'Thu, Mar 7 · 2:30 PM',
      status: 'Pending',
      statusColor: Color(0xFFFFB340),
      imageIcon: Icons.business_rounded,
    ),
    _VisitData(
      title: 'Heritage Villa Estate',
      address: '8 Wisteria Lane, Greenfield',
      date: 'Fri, Mar 8 · 11:00 AM',
      status: 'Confirmed',
      statusColor: Color(0xFF34C88A),
      imageIcon: Icons.villa_rounded,
    ),
    _VisitData(
      title: 'Rooftop Loft Studio',
      address: '301 Creative Quarter, 5th St',
      date: 'Mon, Mar 11 · 9:00 AM',
      status: 'Draft',
      statusColor: AppColors.textLight,
      imageIcon: Icons.roofing_rounded,
    ),
    _VisitData(
      title: 'Garden Terrace Complex',
      address: '78 Parkview Lane',
      date: 'Wed, Mar 13 · 3:00 PM',
      status: 'Confirmed',
      statusColor: Color(0xFF34C88A),
      imageIcon: Icons.deck_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: PageHeader(
            title: 'Site Visits',
            subtitle: '${_visits.length} upcoming visits',
            action: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_rounded, color: AppColors.primary, size: 18),
                  SizedBox(width: 4),
                  Text('Schedule',
                      style: TextStyle(
                          color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),

        // Stat chips
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                _StatChip(label: 'This Week', value: '3', icon: Icons.calendar_today_rounded),
                SizedBox(width: 12),
                _StatChip(label: 'Confirmed', value: '3', icon: Icons.check_circle_outline_rounded),
                SizedBox(width: 12),
                _StatChip(label: 'Pending',   value: '1', icon: Icons.hourglass_top_rounded),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _VisitCard(data: _visits[i]),
              ),
              childCount: _visits.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}

// Visits — data model
class _VisitData {
  final String title, address, date, status;
  final Color statusColor;
  final IconData imageIcon;

  const _VisitData({
    required this.title,   required this.address,
    required this.date,    required this.status,
    required this.statusColor, required this.imageIcon,
  });
}

// Visits — stat chip
class _StatChip extends StatelessWidget {
  final String label, value;
  final IconData icon;

  const _StatChip({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 18),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textDark)),
            Text(label,
                style: const TextStyle(fontSize: 11, color: AppColors.textMid)),
          ],
        ),
      ),
    );
  }
}

// Visits — card
class _VisitCard extends StatelessWidget {
  final _VisitData data;

  const _VisitCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return LuxuryCard(
      padding: EdgeInsets.zero,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            // Icon block
            Container(
              width: 54, height: 54,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(data.imageIcon, color: AppColors.primary, size: 26),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      StatusBadge(label: data.status, color: data.statusColor),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(data.address,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMid),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded, size: 13, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(data.date,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textLight, size: 20),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// TAB 2 — ACTIVITY PAGE
// ══════════════════════════════════════════════
class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  static final _logs = [
    _ActivityData(icon: Icons.add_location_alt_rounded, color: Color(0xFF34C88A),
        title: 'New visit scheduled',         detail: 'Oceanfront Penthouse — 10:00 AM',        time: '2 min ago'),
    _ActivityData(icon: Icons.edit_note_rounded,        color: AppColors.primary,
        title: 'Report updated',              detail: 'Heritage Villa Estate inspection notes',  time: '1 hour ago'),
    _ActivityData(icon: Icons.person_add_rounded,       color: Color(0xFF9B59B6),
        title: 'Client assigned',             detail: 'Marcus Reynolds → Midtown Office Tower',  time: '3 hours ago'),
    _ActivityData(icon: Icons.check_circle_rounded,     color: Color(0xFF34C88A),
        title: 'Visit completed',             detail: 'Rooftop Loft Studio — all checkpoints',   time: 'Yesterday, 4:15 PM'),
    _ActivityData(icon: Icons.photo_camera_rounded,     color: Color(0xFFFFB340),
        title: 'Photos uploaded',             detail: '18 images added to Garden Terrace report',time: 'Yesterday, 2:00 PM'),
    _ActivityData(icon: Icons.notification_important_rounded, color: Color(0xFFE74C3C),
        title: 'Alert: Access issue',         detail: 'Key code expired at 55 Park Avenue',      time: 'Yesterday, 11:30 AM'),
    _ActivityData(icon: Icons.star_rounded,             color: Color(0xFFFFB340),
        title: 'Review received',             detail: '5-star rating from Sophia Chen',           time: '2 days ago'),
    _ActivityData(icon: Icons.file_download_done_rounded, color: AppColors.primary,
        title: 'Contract signed',             detail: 'Property assessment — Wisteria Lane',      time: '3 days ago'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: PageHeader(title: 'Activity', subtitle: 'Recent updates'),
        ),

        // Mini bar chart
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LuxuryCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Visits This Month',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  const Text('23 total · ↑ 12% from last month',
                      style: TextStyle(fontSize: 12, color: AppColors.textMid)),
                  const SizedBox(height: 16),
                  const _MiniChart(),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Recent activity',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700,
                    color: AppColors.textDark, letterSpacing: -0.2)),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (ctx, i) => _ActivityRow(data: _logs[i], isLast: i == _logs.length - 1),
              childCount: _logs.length,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

// Activity — bar chart
class _MiniChart extends StatelessWidget {
  const _MiniChart();
  static const _values = [4, 7, 5, 9, 6, 11, 8, 13, 10, 14, 12, 16];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _values.map((v) {
          final fraction = v / 16.0;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                height: 70 * fraction,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary.withOpacity(0.3), AppColors.primary],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Activity — data model
class _ActivityData {
  final IconData icon;
  final Color color;
  final String title, detail, time;

  const _ActivityData({
    required this.icon, required this.color,
    required this.title, required this.detail, required this.time,
  });
}

// Activity — row with timeline connector
class _ActivityRow extends StatelessWidget {
  final _ActivityData data;
  final bool isLast;

  const _ActivityRow({required this.data, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: data.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(data.icon, color: data.color, size: 18),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5, color: AppColors.divider,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(data.title,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      ),
                      Text(data.time,
                          style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(data.detail,
                      style: const TextStyle(fontSize: 12, color: AppColors.textMid)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════
// TAB 3 — PROFILE PAGE
// ══════════════════════════════════════════════
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notifications = true;
  bool _biometrics    = false;
  bool _darkMode      = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: PageHeader(title: 'Profile', subtitle: 'Manage your account'),
        ),

        // ── Avatar card ──────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LuxuryCard(
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 72, height: 72,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF6FB3F5), AppColors.primaryDark],
                            begin: Alignment.topLeft, end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Text('AL',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700)),
                        ),
                      ),
                      Positioned(
                        bottom: 0, right: 0,
                        child: Container(
                          width: 22, height: 22,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.white, width: 2),
                          ),
                          child: const Icon(Icons.edit_rounded, color: Colors.white, size: 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Alexandra Lin',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                        const SizedBox(height: 2),
                        const Text('alex@lumina.co',
                            style: TextStyle(fontSize: 13, color: AppColors.textMid)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Pro Inspector',
                              style: TextStyle(
                                  color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // ── Stats row ────────────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                _ProfileStat(label: 'Total Visits', value: '247'),
                SizedBox(width: 12),
                _ProfileStat(label: 'This Month',   value: '23'),
                SizedBox(width: 12),
                _ProfileStat(label: 'Rating',       value: '4.9★'),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        // ── Toggle settings ──────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LuxuryCard(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  _SettingsTile(
                    icon: Icons.notifications_outlined,
                    label: 'Push Notifications',
                    trailing: Switch.adaptive(
                      value: _notifications, activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _notifications = v),
                    ),
                  ),
                  const _Divider(),
                  _SettingsTile(
                    icon: Icons.fingerprint_rounded,
                    label: 'Biometric Login',
                    trailing: Switch.adaptive(
                      value: _biometrics, activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _biometrics = v),
                    ),
                  ),
                  const _Divider(),
                  _SettingsTile(
                    icon: Icons.dark_mode_outlined,
                    label: 'Dark Mode',
                    trailing: Switch.adaptive(
                      value: _darkMode, activeColor: AppColors.primary,
                      onChanged: (v) => setState(() => _darkMode = v),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        // ── Navigation tiles ─────────────────────────────────
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LuxuryCard(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  _SettingsTile(
                      icon: Icons.person_outline_rounded, label: 'Edit Profile',
                      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textLight)),
                  const _Divider(),
                  _SettingsTile(
                      icon: Icons.lock_outline_rounded, label: 'Change Password',
                      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textLight)),
                  const _Divider(),
                  _SettingsTile(
                      icon: Icons.support_agent_rounded, label: 'Help & Support',
                      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textLight)),
                  const _Divider(),
                  _SettingsTile(
                    icon: Icons.logout_rounded, label: 'Sign Out',
                    labelColor: const Color(0xFFE74C3C),
                    iconColor:  const Color(0xFFE74C3C),
                    trailing: const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }
}

// Profile — stat tile
class _ProfileStat extends StatelessWidget {
  final String label, value;

  const _ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.primary)),
            const SizedBox(height: 3),
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMid)),
          ],
        ),
      ),
    );
  }
}

// Profile — settings list tile
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;
  final Color? labelColor;
  final Color? iconColor;

  const _SettingsTile({
    required this.icon, required this.label, required this.trailing,
    this.labelColor, this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.primary).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor ?? AppColors.primary, size: 18),
      ),
      title: Text(label,
          style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500,
            color: labelColor ?? AppColors.textDark,
          )),
      trailing: trailing,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}

// Shared thin divider for settings cards
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: AppColors.divider, height: 1),
    );
  }
}