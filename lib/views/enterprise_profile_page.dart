import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/bizmap_service.dart';
import '../widgets/edit_dashboard_dialog.dart';

class EnterpriseProfilePage extends StatelessWidget {
  const EnterpriseProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bizService = BizMapService();

    return AnimatedBuilder(
      animation: bizService,
      builder: (context, _) {
        final summary = bizService.dashboardSummary;
        final isAdmin = bizService.isAdmin;

        final regPercentage = summary.totalEnterprises > 0
            ? ((summary.registeredBusinesses / summary.totalEnterprises) * 100).toStringAsFixed(1)
            : '0';

        final lguPercentage = summary.totalEnterprises > 0
            ? ((summary.receivedLguAssistance / summary.totalEnterprises) * 100).toStringAsFixed(1)
            : '0';

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFC59B27),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'ENTERPRISE PROFILE DASHBOARD',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.1,
                                    color: Color(0xFF0D472B),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Barangay Casile, City of Cabuyao • Socio-Economic Enterprise Demographics',
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blueGrey.shade200),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.verified_user, size: 14, color: Color(0xFF0D472B)),
                                SizedBox(width: 6),
                                Text(
                                  'All Data Provided by Admin',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF0D472B)),
                                ),
                              ],
                            ),
                          ),
                          if (isAdmin) ...[
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () => EditDashboardDialog.show(context, summary),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D472B),
                                foregroundColor: Colors.white,
                              ),
                              icon: const Icon(Icons.edit, size: 16),
                              label: const Text('Edit Metrics'),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Top 4 Metrics Cards
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatCard(
                                  title: 'Total Enterprises',
                                  value: '${summary.totalEnterprises}',
                                  subtitle: 'Surveyed MSMEs in Casile',
                                  icon: Icons.storefront_rounded,
                                  accentColor: const Color(0xFF0D472B),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildStatCard(
                                  title: 'Registered Businesses',
                                  value: '${summary.registeredBusinesses}',
                                  subtitle: '$regPercentage% compliance rate',
                                  icon: Icons.verified_rounded,
                                  accentColor: const Color(0xFF198754),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatCard(
                                  title: 'LGU Assistance',
                                  value: '${summary.receivedLguAssistance}',
                                  subtitle: '$lguPercentage% received City support',
                                  icon: Icons.handshake_rounded,
                                  accentColor: const Color(0xFFC59B27),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildStatCard(
                                  title: 'Main Business Type',
                                  value: summary.mainBusinessType,
                                  subtitle: 'Highest sectoral concentration',
                                  icon: Icons.pie_chart_rounded,
                                  accentColor: const Color(0xFF0C2340),
                                  isTextValue: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 36),

                  // Section 1: Type of Businesses & Nature of Ownership
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type of businesses breakdown
                      Expanded(
                        flex: 6,
                        child: _buildSectionCard(
                          title: 'Type of Businesses (Sector Distribution)',
                          icon: Icons.category_rounded,
                          child: _buildDistributionList(
                            summary.businessTypes,
                            summary.totalEnterprises,
                            const Color(0xFF0D472B),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Nature of Ownership
                      Expanded(
                        flex: 5,
                        child: _buildSectionCard(
                          title: 'Nature of Ownership',
                          icon: Icons.account_balance_rounded,
                          child: _buildOwnershipChartAndList(summary.natureOfOwnership, summary.totalEnterprises),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Section 2: Number of Employees & Years of Operation
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Number of Employees
                      Expanded(
                        child: _buildSectionCard(
                          title: 'Number of Employees (Workforce Size)',
                          icon: Icons.groups_rounded,
                          child: _buildDistributionList(
                            summary.employeeDistribution,
                            summary.totalEnterprises,
                            const Color(0xFF198754),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Years of Operation
                      Expanded(
                        child: _buildSectionCard(
                          title: 'Years of Operation (Business Longevity)',
                          icon: Icons.timeline_rounded,
                          child: _buildDistributionList(
                            summary.yearsOfOperation,
                            summary.totalEnterprises,
                            const Color(0xFFC59B27),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Section 3: Estimated Capitalization & Annual Sales
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Capitalization
                      Expanded(
                        child: _buildSectionCard(
                          title: 'Estimated Capitalization',
                          icon: Icons.payments_rounded,
                          child: _buildDistributionList(
                            summary.capitalizationDistribution,
                            summary.totalEnterprises,
                            const Color(0xFF0D472B),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Annual Sales
                      Expanded(
                        child: _buildSectionCard(
                          title: 'Estimated Annual Sales',
                          icon: Icons.trending_up_rounded,
                          child: _buildDistributionList(
                            summary.annualSalesDistribution,
                            summary.totalEnterprises,
                            const Color(0xFF0C2340),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Section 4: Business Registrations Acquired
                  _buildSectionCard(
                    title: 'Business Registration Compliance by Type',
                    icon: Icons.assignment_turned_in_rounded,
                    child: _buildRegistrationBadges(summary.businessRegistrations, summary.totalEnterprises),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    bool isTextValue = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accentColor, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isTextValue ? 17 : 26,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: const Color(0xFF0D472B)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDistributionList(Map<String, int> data, int total, Color color) {
    if (data.isEmpty) {
      return const Text('No distribution data recorded.');
    }

    final maxVal = data.values.fold<int>(0, (prev, val) => val > prev ? val : prev);

    return Column(
      children: data.entries.map((entry) {
        final ratio = total > 0 ? (entry.value / total) : 0.0;
        final barFactor = maxVal > 0 ? (entry.value / maxVal) : 0.0;
        final pctString = (ratio * 100).toStringAsFixed(1);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      entry.key,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    '${entry.value} ($pctString%)',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: barFactor.clamp(0.0, 1.0),
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade100,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOwnershipChartAndList(Map<String, int> data, int total) {
    final colors = [
      const Color(0xFF0D472B),
      const Color(0xFFC59B27),
      const Color(0xFF198754),
      const Color(0xFF0C2340),
    ];

    int colorIdx = 0;
    final sections = <PieChartSectionData>[];
    final items = <Widget>[];

    data.forEach((key, val) {
      final c = colors[colorIdx % colors.length];
      colorIdx++;
      final pct = total > 0 ? (val / total * 100).toStringAsFixed(1) : '0';

      sections.add(
        PieChartSectionData(
          value: val.toDouble(),
          color: c,
          radius: 38,
          showTitle: false,
        ),
      );

      items.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(width: 12, height: 12, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(key, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              ),
              Text(
                '$val ($pct%)',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    });

    return Row(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 24,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(child: Column(children: items)),
      ],
    );
  }

  Widget _buildRegistrationBadges(Map<String, int> data, int total) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: data.entries.map((entry) {
        final pct = total > 0 ? ((entry.value / total) * 100).toStringAsFixed(0) : '0';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D472B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.verified, size: 18, color: Color(0xFF0D472B)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.key,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${entry.value} establishments ($pct% of total)',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
