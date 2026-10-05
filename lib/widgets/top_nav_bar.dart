import 'package:flutter/material.dart';
import '../services/bizmap_service.dart';

class TopNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onAdminToggle;

  const TopNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onAdminToggle,
  });

  static const List<Map<String, dynamic>> navItems = [
    {'title': 'Home', 'icon': Icons.home_rounded},
    {'title': 'Enterprise Profile', 'icon': Icons.analytics_rounded},
    {'title': 'Support Needs', 'icon': Icons.handshake_rounded},
    {'title': 'Challenges', 'icon': Icons.warning_amber_rounded},
    {'title': 'Establishment Profiles', 'icon': Icons.storefront_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final bizService = BizMapService();
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          // Logo & Branding
          InkWell(
            onTap: () => onItemSelected(0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D472B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF0D472B).withOpacity(0.2)),
                  ),
                  child: const Icon(
                    Icons.map_rounded,
                    color: Color(0xFF0D472B),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BIZMAP CABUYAO',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        letterSpacing: 1.2,
                        color: Color(0xFF0D472B),
                      ),
                    ),
                    Text(
                      'Brgy. Casile Economic Portal',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Spacer(),

          // Navigation Links (Desktop)
          if (isDesktop) ...[
            Row(
              children: List.generate(navItems.length, (index) {
                final isSelected = selectedIndex == index;
                final item = navItems[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () => onItemSelected(index),
                    borderRadius: BorderRadius.circular(8),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF0D472B)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: 18,
                            color: isSelected ? Colors.white : Colors.grey.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item['title'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(width: 16),
          ],

          // Admin Mode Toggle
          AnimatedBuilder(
            animation: bizService,
            builder: (context, _) {
              final isAdmin = bizService.isAdmin;
              return ElevatedButton.icon(
                onPressed: onAdminToggle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAdmin ? const Color(0xFFD32F2F) : const Color(0xFFC59B27),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                icon: Icon(
                  isAdmin ? Icons.admin_panel_settings : Icons.lock_outline,
                  size: 17,
                ),
                label: Text(
                  isAdmin ? 'Admin (Active)' : 'Admin Login',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
