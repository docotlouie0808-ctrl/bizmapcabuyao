import 'package:flutter/material.dart';
import '../services/bizmap_service.dart';
import '../widgets/title_ribbon.dart';
import '../widgets/member_card.dart';
import '../widgets/add_member_dialog.dart';

class HomePage extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const HomePage({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final bizService = BizMapService();
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mandatory Title Ribbon as specified
          const TitleRibbon(
            title: 'Brgy.Casile City, City of cabuyao',
            subtitle: 'Enterprise & Micro-Business Profiling Research Project',
          ),

          // Hero Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0D472B).withOpacity(0.04),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  children: [
                    // Official Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC59B27).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFC59B27).withOpacity(0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.verified_outlined, size: 18, color: Color(0xFF996515)),
                          SizedBox(width: 8),
                          Text(
                            'Local Economic Development & Micro-Enterprise Research Portal',
                            style: TextStyle(
                              color: Color(0xFF996515),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Comprehensive Socio-Economic Profiling\nof Barangay Casile, City of Cabuyao',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        height: 1.25,
                        color: Color(0xFF0F2B1D),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Text(
                        'A dedicated research portal mapping micro, small, and medium enterprises (MSMEs) in Barangay Casile. '
                        'Explore statistical distributions of local business ownership, capital, employment, registration status, '
                        'critical business support requirements, and financing challenges.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Quick Nav Action Buttons
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => onNavigate(1),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D472B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 2,
                          ),
                          icon: const Icon(Icons.analytics_outlined),
                          label: const Text('View Enterprise Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => onNavigate(4),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF0D472B),
                            side: const BorderSide(color: Color(0xFF0D472B), width: 1.5),
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(Icons.storefront_outlined),
                          label: const Text('Browse Establishments Directory', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Portal Highlights Banner
          Container(
            color: const Color(0xFF0D472B),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: AnimatedBuilder(
                  animation: bizService,
                  builder: (context, _) {
                    final summary = bizService.dashboardSummary;
                    final totalEst = bizService.establishments.length;

                    return Wrap(
                      spacing: 32,
                      runSpacing: 20,
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        _buildHeroStat(
                          '${summary.totalEnterprises}',
                          'Total Surveyed Enterprises',
                          Icons.apartment_rounded,
                        ),
                        _buildHeroStat(
                          '$totalEst',
                          'Documented Profiles',
                          Icons.inventory_2_outlined,
                        ),
                        _buildHeroStat(
                          '${summary.registeredBusinesses}',
                          'Registered Businesses',
                          Icons.verified_user_outlined,
                        ),
                        _buildHeroStat(
                          '${summary.receivedLguAssistance}',
                          'LGU Assistance Recipients',
                          Icons.handshake_outlined,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          // Research Members Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Header with Admin Action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC59B27),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'RESEARCH TEAM MEMBERS',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: Color(0xFF0D472B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'The researchers leading the enterprise profiling and socio-economic survey in Brgy. Casile.',
                              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                            ),
                          ],
                        ),

                        // Admin Add Member Button
                        AnimatedBuilder(
                          animation: bizService,
                          builder: (context, _) {
                            if (!bizService.isAdmin) {
                              return const SizedBox.shrink();
                            }
                            return ElevatedButton.icon(
                              onPressed: () => AddMemberDialog.show(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D472B),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              icon: const Icon(Icons.add_a_photo, size: 18),
                              label: const Text(
                                'Add Member (Max 2MB)',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Grid of Members
                    AnimatedBuilder(
                      animation: bizService,
                      builder: (context, _) {
                        final members = bizService.researchers;
                        if (members.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Text(
                                'No research members added yet. Admins can add members.',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                          );
                        }

                        // Responsive Grid layout
                        final crossAxisCount = screenWidth > 1000
                            ? 4
                            : (screenWidth > 680 ? 2 : 1);

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: members.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                          itemBuilder: (context, index) {
                            return MemberCard(member: members[index]);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Portal Directory Cards (Enterprise Profile, Support Needs, Challenges, Profiles)
          Container(
            color: Colors.grey.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  children: [
                    const Text(
                      'EXPLORE RESEARCH FINDINGS & PROFILES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0D472B),
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Direct access to official data modules and demographic breakdowns',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                    const SizedBox(height: 36),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isDesktop = constraints.maxWidth >= 700;
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildNavigationCard(
                                    title: 'Enterprise Profile Dashboard',
                                    description: 'Statistics on total enterprises, capitalization, sales, ownership, and LGU assistance.',
                                    icon: Icons.pie_chart_rounded,
                                    badge: 'Analytics',
                                    onTap: () => onNavigate(1),
                                  ),
                                ),
                                if (isDesktop) const SizedBox(width: 20),
                                if (isDesktop)
                                  Expanded(
                                    child: _buildNavigationCard(
                                      title: 'Business Support Needs',
                                      description: 'Prioritized needs in financing, digital marketing, bookkeeping, and training.',
                                      icon: Icons.volunteer_activism_rounded,
                                      badge: 'Support',
                                      onTap: () => onNavigate(2),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                if (!isDesktop) ...[
                                  Expanded(
                                    child: _buildNavigationCard(
                                      title: 'Business Support Needs',
                                      description: 'Prioritized needs in financing, digital marketing, bookkeeping, and training.',
                                      icon: Icons.volunteer_activism_rounded,
                                      badge: 'Support',
                                      onTap: () => onNavigate(2),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                                Expanded(
                                  child: _buildNavigationCard(
                                    title: 'Business Challenges',
                                    description: 'Documented roadblocks including access to formal bank financing, interest rates, and terrain.',
                                    icon: Icons.warning_amber_rounded,
                                    badge: 'Challenges',
                                    onTap: () => onNavigate(3),
                                  ),
                                ),
                                if (isDesktop) const SizedBox(width: 20),
                                if (isDesktop)
                                  Expanded(
                                    child: _buildNavigationCard(
                                      title: 'Profile Per Establishment',
                                      description: 'Searchable directory of registered enterprises, business types, ID numbers, and permits.',
                                      icon: Icons.list_alt_rounded,
                                      badge: 'Directory',
                                      onTap: () => onNavigate(4),
                                    ),
                                  ),
                              ],
                            ),
                            if (!isDesktop) ...[
                              const SizedBox(height: 20),
                              _buildNavigationCard(
                                title: 'Profile Per Establishment',
                                description: 'Searchable directory of registered enterprises, business types, ID numbers, and permits.',
                                icon: Icons.list_alt_rounded,
                                badge: 'Directory',
                                onTap: () => onNavigate(4),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String value, String label, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFFFFDF73), size: 28),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.85),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigationCard({
    required String title,
    required String description,
    required IconData icon,
    required String badge,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D472B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: const Color(0xFF0D472B), size: 26),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC59B27).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B6508),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Text(
                    'Explore Data',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D472B),
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF0D472B)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
