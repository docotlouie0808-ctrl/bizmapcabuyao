import 'package:flutter/material.dart';
import '../widgets/admin_dialog.dart';

class PortalFooter extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const PortalFooter({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0C2340), // Midnight Navy
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1: Project Info
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.map_rounded, color: Color(0xFFFFDF73), size: 22),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'BIZMAP CABUYAO',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'A specialized socio-economic profiling and micro-enterprise mapping initiative for Barangay Casile, City of Cabuyao, Laguna.',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 13, height: 1.5),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 32),

                  // Column 2: Portal Sections
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SECTIONS',
                          style: TextStyle(
                            color: Color(0xFFFFDF73),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFooterLink('Home & Researchers', () => onNavigate(0)),
                        _buildFooterLink('Enterprise Profile', () => onNavigate(1)),
                        _buildFooterLink('Business Support Needs', () => onNavigate(2)),
                        _buildFooterLink('Business Challenges', () => onNavigate(3)),
                        _buildFooterLink('Establishment Directory', () => onNavigate(4)),
                      ],
                    ),
                  ),

                  // Column 3: Administration
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PORTAL ACCESS',
                          style: TextStyle(
                            color: Color(0xFFFFDF73),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () => AdminDialog.show(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: const [
                                Icon(Icons.admin_panel_settings_outlined, color: Colors.white70, size: 16),
                                SizedBox(width: 6),
                                Text(
                                  'Admin Management',
                                  style: TextStyle(color: Colors.white70, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'All statistical parameters, researcher profiles, and establishment records can be updated in real-time by authorized administrators.',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 11, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Divider(color: Colors.white24, height: 48),

              // Bottom Attribution
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '© 2024-2026 Brgy. Casile, City of Cabuyao • Enterprise Mapping Research',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                  Text(
                    'Empowering Local Enterprises & Policy Planning',
                    style: TextStyle(color: const Color(0xFFFFDF73).withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLink(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
    );
  }
}
