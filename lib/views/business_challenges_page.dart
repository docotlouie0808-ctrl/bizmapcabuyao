import 'package:flutter/material.dart';
import '../services/bizmap_service.dart';
import '../models/enterprise_data.dart';

class BusinessChallengesPage extends StatelessWidget {
  const BusinessChallengesPage({super.key});

  void _showAddChallengeDialog(BuildContext context, bool isFinancing) {
    final titleController = TextEditingController();
    final countController = TextEditingController();
    final pctController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isFinancing ? 'Add Access to Financing Challenge' : 'Add Operational / Market Challenge'),
        content: SizedBox(
          width: 450,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Challenge Title *', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: countController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Affected Businesses', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: pctController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Percentage (%)', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Context & Qualitative Impact', border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD32F2F)),
            onPressed: () {
              if (titleController.text.trim().isEmpty) return;
              final newItem = SupportNeedItem(
                title: titleController.text.trim(),
                count: int.tryParse(countController.text.trim()) ?? 0,
                percentage: double.tryParse(pctController.text.trim()) ?? 0.0,
                description: descController.text.trim(),
              );

              final bizService = BizMapService();
              final current = bizService.challengesData;

              List<SupportNeedItem> financing = List.from(current.financingChallenges);
              List<SupportNeedItem> others = List.from(current.otherChallenges);

              if (isFinancing) {
                financing.add(newItem);
              } else {
                others.add(newItem);
              }

              bizService.updateBusinessChallengesData(BusinessChallengesData(
                financingChallenges: financing,
                otherChallenges: others,
              ));

              Navigator.of(ctx).pop();
            },
            child: const Text('Save Challenge', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bizService = BizMapService();

    return AnimatedBuilder(
      animation: bizService,
      builder: (context, _) {
        final challenges = bizService.challengesData;
        final isAdmin = bizService.isAdmin;

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
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD32F2F),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'BUSINESS CHALLENGES',
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
                            'Critical bottlenecks, with primary emphasis on Access to Financing Challenges in Brgy. Casile.',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
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
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Spotlight Banner for Access to Financing Challenges
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFB71C1C).withOpacity(0.08),
                          Colors.amber.shade50,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFB71C1C).withOpacity(0.2)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB71C1C),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Focal Research Focus: Access to Financing Barriers',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFFB71C1C),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Survey findings show that capital scarcity and severe friction in the banking sector '
                                'force 66% of surveyed enterprises in Barangay Casile into predatory informal financing networks (5-6), '
                                'limiting long-term growth and capital accumulation.',
                                style: TextStyle(fontSize: 13, height: 1.45, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Primary Section: Access to Financing Challenges
                  _buildChallengeSection(
                    title: 'Access to Financing Challenges',
                    subtitle: 'Detailed breakdown of capital and banking roadblocks reported by local owners',
                    icon: Icons.payments_rounded,
                    items: challenges.financingChallenges,
                    accentColor: const Color(0xFFD32F2F),
                    isAdmin: isAdmin,
                    onAdd: () => _showAddChallengeDialog(context, true),
                  ),

                  const SizedBox(height: 32),

                  // Secondary Section: Operational & Market Challenges
                  _buildChallengeSection(
                    title: 'Operational, Geographic & Market Challenges',
                    subtitle: 'Supply chain, upland logistics, and competitive dynamics in Casile',
                    icon: Icons.trending_down_rounded,
                    items: challenges.otherChallenges,
                    accentColor: const Color(0xFF455A64),
                    isAdmin: isAdmin,
                    onAdd: () => _showAddChallengeDialog(context, false),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChallengeSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<SupportNeedItem> items,
    required Color accentColor,
    required bool isAdmin,
    required VoidCallback onAdd,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accentColor, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                if (isAdmin)
                  OutlinedButton.icon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Challenge'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: accentColor,
                      side: BorderSide(color: accentColor),
                    ),
                  ),
              ],
            ),
            const Divider(height: 28),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('No challenges currently recorded.', style: TextStyle(color: Colors.grey.shade600)),
              )
            else
              Column(
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.priority_high_rounded, color: accentColor, size: 16),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: accentColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${item.percentage.toStringAsFixed(1)}% (${item.count} establishments)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: accentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (item.percentage / 100.0).clamp(0.0, 1.0),
                              minHeight: 6,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                            ),
                          ),
                          if (item.description.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Text(
                              item.description,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
